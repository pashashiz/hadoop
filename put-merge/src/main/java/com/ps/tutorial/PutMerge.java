package com.ps.tutorial;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;

import java.io.IOException;

public class PutMerge {

    /**
     * Merge files from local directory to one file in HDFS
     *
     * @param args arg[0] local file system directory with files for merging,
     *             arg[1] HDFS output file (which wil contain the merged content of all local files)
     */
    public static void main(String[] args) {
        Path inLocalDir = new Path(args[0]);
        Path outHdfsFile = new Path(args[1]);
        System.out.println("Merge content from " + inLocalDir + " to " + outHdfsFile);
        Configuration conf = new Configuration();
        try {
            FileSystem local = FileSystem.getLocal(conf);
            FileSystem hdfs = FileSystem.get(conf);
            FileStatus[] inLocalFiles = local.listStatus(inLocalDir);
            FSDataOutputStream out = hdfs.create(outHdfsFile);
            for (FileStatus file : inLocalFiles) {
                System.out.println("Add content from " + file.getPath() + " file");
                FSDataInputStream in = local.open(file.getPath());
                byte[] buffer = new byte[256];
                int read;
                while ((read = in.read(buffer)) > 0)
                    out.write(buffer, 0, read);
                out.writeChar('\n');
                in.close();
            }
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
