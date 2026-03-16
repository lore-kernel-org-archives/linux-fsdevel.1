Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C05361DA7;
	Mon, 16 Mar 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700642; cv=none; b=aVANjOQsFp3FLLM1xytLwG2QXg4mRmPkL/b16EzwRQv/ciROoY8i4p0eg45OrZ0nrXGsdQfYlrPqIO4woCYCrEzP+mzmpi/gGBa0dnOuyNsndteefhpHBP1CpinHC2Qm9sCUHT50qRGm8AzVLwcUoRj4i2L9fCa8BC/MsjzolNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700642; c=relaxed/simple;
	bh=8W1+qvl34fIhLpwx+ypQ8CktR2a2qKFFKJUkbK1AD3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naQsUM30bhLO9ZYAKQByPDcwVItYMFBRrb6qHlXQrIqW/RjQcPqJCVmQF393fgJSGbDXnV32KQKpfmEdCSfr+pXAnLRlvo/9T6gW+w4jk9SNt1TxYnlOAgbSRXL3LwjR8oQ12cCEKFkJHHZj+VyRLLVtZ8uj+i/axxWjzETwewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=sWRHXUVo; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="sWRHXUVo"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id E63D91CBC0;
	Mon, 16 Mar 2026 22:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me E63D91CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773700640; bh=8W1+qvl34fIhLpwx+ypQ8CktR2a2qKFFKJUkbK1AD3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sWRHXUVoXu7ictI2DGeGvjZBbshNDBR6HGMdvEFbJBHEnBPqH9K5/heax8aZaVWMJ
	 E9XiiOesAdUVk9/7B3JrIFDTnljjWMwq1a3ETWcgay7sQ6hG+gaVjfFHg+SbW01LS5
	 y6DWPJBp61m6ndjsCfQe4wX01MwRp8pneycematI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id reOkJh6GuGmZrAYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 16 Mar 2026 22:37:18 +0000
Message-ID: <898f4927-30a4-4ccb-b080-9e4d2fe3af1e@dev.snart.me>
Date: Tue, 17 Mar 2026 07:37:14 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: "Darrick J. Wong" <djwong@kernel.org>, linkinjeon@kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, linkinjeon@kernel.org,
 sj1557.seo@samsung.com, yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
 <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs>
 <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
 <20260313162408.GE6023@frogsfrogsfrogs>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260313162408.GE6023@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/26 22:59, Namjae Jeon wrote:
> I'm working on adding iomap support to exFAT, and I think SEEK_HOLE
> will be able to address the requirements we discussed. I will bring
> this up again once the iomap work is complete.
Good! exFAT not constructed using iomap leading to an eventual
catastrophic tech debt has been one of my concerns. Since you're working
on it, you'd naturally implement FIEMAP as well, right? I was cooking up
a quick and dirty functions for FIEMAP... Not sure if you're interested
in them, but would happy to submit in the future. It's only a
kernel-specific interface almost no userspace uses, but really
insightful tool in analyzing fragmentation issue I'm trying to solve.
Might come in handy in the meantime the new iomap implementation is
settling down.

On 3/14/26 01:24, Darrick J. Wong wrote:
> Ah, ok.  Does it do that zeroing at write() time, or only when you're
> initiating writeback from the pagecache?  I'm guessing write() time,
> since otherwise you're signing the kernel up for initiating a lot of IO
> at a time when memory could be scarce.
NO! That'd be insane! I'm pretty sure faults are handled "sparsely".
> In contrast, lot of people call readable file regions not backed by any
> space "sparse holes".  Unfortunately the fallocate manpage muddies
> things up by saying:
Yes, that to which I myself have fallen victim. Thank you for such a
great insight from a filesystem guru, btw.

> OTOH I guess they could confirm that by calling the VDL ioctl and
> getting a non-error response.  But if we've solved finding the VDL by
> making SEEK_HOLE return values below EOF, then why do we need the ioctl?
> What if we added a statx flag to advertise sparse hole support on a
> file?  And then didn't set it for exfat?
> /me notes that you can implement iomap only for lseek.
Yes, I'm aware. Was just expressing my concerns regarding the tech debt
in exFAT mentioned earlier. Just swapped back in differently from my head.

Anyway, admitting my recent defeat, I've been toying with the idea of
using SEEK_DATA and SEEK_HOLE for detecting the [VDL - isize)
discrepancy(attached at the end of the email). Not making an official
submission yet because I've been testing if it breaks any critial
userland utils. So far, so good. A bunch of xfstests fail, though. The
ones written with the assumption that filesystems that support SEEK_DATA
and SEEK_HOLE can always have data or hole in the middle(which I'd like
to call "hole sandwich/burger" and "data sandwich/burger",
respectively). This was what I was worried about and it seems it
actually manifested.

generic/285:
> 05.15 SEEK_HOLE expected -1 with errno -6, got -6.               
> succ  ERROR 28: Failed to write 524288 bytes
generic/490:
> File system does not support punch hole.
>   ERROR 28: Failed to write 32768 bytes
Not sure why all the units "succ" whilst the program returns non-zero
exit code before saying:
> seek sanity check failed!
Might have to fix the test program to catch the misbehaving filesystems
that returns other erronos.

Davo

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 2daf0dbabb24..99ba1f5f9a57 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -799,8 +799,80 @@ static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
     return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
+/*
+ * A special SEEK_DATA and SEEK_HOLE handler that treats the unwritten range
+ * between the VDL(valid data length) and EOF as a hole. Since the VDL in exFAT
+ * is not required to be aligned to any block boundary and holes in extent-based
+ * filesystems are typically aligned to a certain block size, we try our best to
+ * align the VDL to the device block size as not to confuse any userland
+ * programs that may depend on that assumption.
+ *
+ * The function will treat the last block containing data as the last data block
+ * and the block that follows immediately after as the start of the hole leading
+ * up to EOF. The last data block may have some unwritten bytes, but that's only
+ * O(1) write amplification.
+ */
+static loff_t exfat_vdl_llseek(struct file *file, loff_t offset, int whence)
+{
+    struct inode *inode = file->f_mapping->host;
+    struct super_block *sb = inode->i_sb;
+    struct exfat_inode_info *ei = EXFAT_I(inode);
+    loff_t maxbytes = inode->i_sb->s_maxbytes;
+    loff_t datasize;
+    loff_t size;
+
+    inode_lock(inode);
+
+    size = i_size_read(inode);
+
+    datasize = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
+    datasize = EXFAT_BLK_TO_B(datasize, sb);
+    if (datasize > size)
+        datasize = size;
+
+    /* Same check found in iomap_seek_*() */
+    if (offset < 0 || offset >= size) {
+        offset = -ENXIO;
+        goto out;
+    }
+
+    if (whence == SEEK_DATA) {
+        /*
+         * As exFAT does not support sparse files, SEEK_DATA is pretty
+         * much useless. But still, to be compliant, SEEK_DATA shouldn't
+         * work if the offset is in a hole.
+         */
+        if (offset >= datasize)
+            offset = -ENXIO;
+    }
+    else if (whence == SEEK_HOLE) {
+        if (offset < datasize)
+            offset = datasize;
+    }
+    else
+        BUG();
+
+out:
+    inode_unlock(inode);
+
+    if (offset < 0) {
+        return offset;
+    }
+
+    return vfs_setpos(file, offset, maxbytes);
+}
+
+static loff_t exfat_file_llseek(struct file *file, loff_t offset, int whence)
+{
+    if (whence == SEEK_DATA || whence == SEEK_HOLE) {
+        return exfat_vdl_llseek(file, offset, whence);
+    }
+
+    return generic_file_llseek(file, offset, whence);
+}
+
 const struct file_operations exfat_file_operations = {
-    .llseek        = generic_file_llseek,
+    .llseek        = exfat_file_llseek,
     .read_iter    = exfat_file_read_iter,
     .write_iter    = exfat_file_write_iter,
     .unlocked_ioctl = exfat_ioctl,


