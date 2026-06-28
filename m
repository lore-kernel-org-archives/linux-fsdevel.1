Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2081C695;
	Sun, 28 Jun 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782672513; cv=none; b=bQbwWmpSSyH2F7pGi6hXYjDshktsZQRaYRESRH9yuu9lWKeEU5DSaMtZ3ts1kj2x5ETf8z2FV9EGYPL62MmCBIrC+dsoJXG/Z07WKOafDjN7MO04mPqJl4TWN3WnY54g14jDHqcxb54MwPYQKoGFiSk4jDjYAfsJQHqXjllD8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782672513; c=relaxed/simple;
	bh=ZRmLW+Eb4bUpd4SR5BVnWYEq6Y+eUTJPj8oZucDGlVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD4cDyKF87wye4cJf8Rv1oAy7CKRYRFPX35v/P0kVwta4fqBilXM/6ZgvC9CgGL+D3fxX2Rtrd8hQ9+qKQV2X8dn5mpn6VpndMrWw+mASgrrhUdnF46qzMVumh11fKYN8ra5acXFM6aPRH4pHzlvcuNVb/pB1AIXLfLgL48Yt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OckDkxan; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OckDkxan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782672501; bh=xP7qFuWRfVSrnxkZX2mq5293jq/nmmFF/B0jM82Bpkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OckDkxanbEuJPR99Ukc3J/sbCmTBTuSV1rWa/RhHyIC38qInQDrcX0YfD8FONDWQK
	 l7W54i/BmgYXyx7AIkTof5mMWjAxmpyQ/FxMxk57NnlR0RoTVbLyhv0gag2hL1UMo/
	 Y2huPSXMioFzNFPmMznykQuQzC9SyF208qL8O9D4=
Received: from [192.168.1.102] ([223.77.180.178])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id C131EE08; Mon, 29 Jun 2026 02:48:19 +0800
X-QQ-mid: xmsmtpt1782672499tbknw1cbs
Message-ID: <tencent_B01B45AE0C90D7229905B906710F6EBBF105@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoek/GR8L1HtbNZ81mh+FQEdVTEARHmJ0XEKhjomO+YUVAaU4WVz7
	 tBFwfO+QqUm9StOWg3ltqr5NCFSAaec05fk34BIaBhGdbGRi51FVA4M0LVMGBZoUEfYLyHAQU+Rs
	 vdmbkvYCVBvVue+bsFVUozDVPGwMmbrsLRgJ1ZyAfhBUKtjzTPVcBypuhoM1jB2/m9IiMociQ4T7
	 JI/s/b7yKVXQVG6B791YUPP0r6tfnEEnYk9bUhkHaiYW0sDuFjE+rpVjQ1gD6jEjb0MKwnahiuD0
	 ieBpPWJ+Y1I7R6WsASAJ3njWm94430MJ3WsH4QxLbRJRntR7aGI3PWcya3ump3/0fmdLw2RlSb2x
	 GQC1o26mrMFa1XO7XSbEe5AQlfzpW3irH7l6D3A5fAxvnxV8yaAR4oT+R7r7Rs0V2LKmuH794XrN
	 92iYwxVYvZfXwf/6w7mRLfKyzHCxEl0T27WDi7kQrYCCFbSbin3W2IQr98JlUS5aIuQSan3gRAzs
	 akv8s3EnjRpbfXb/S2F3Ak7Vi7mes+0c1yf2+wAtbk3iW0iFBEQMktBgj6BiTDd+O+l3qtcSyjed
	 6aestaruNDbMPZcgOJGP5lpK3Sih42m9j7Oa5eldSAoC8xDGM7xAtztTqoOhLBa11jLTISgskVVW
	 MfGOcroUYThd6JBVlHrynS3fKrx/aXAfP4Rq0TOMUtbCoAUvCCey3gU4FHSNqkFvMxA7S8v1uc2f
	 NHlSlKPF6wMHsgN5gYDUnMHKC94mHD1QTqSzM5ZTx47Wtf+l2a8oBNfJ/3lJmgRPesXQ9fS615qk
	 nMy/BmH2Bv0jnArbv/T0I+l+4vUBCHkwfhviy2xDC8v1cjZjRFU1MhD3pJkgPAiAyQnmuWP15R2b
	 vr049fDvLiAilAZsUxRtJUgXvgKJ3TVm70Cjjn8cgYWRJv/YO66S/ABkLeID5xRB6Fr/JRdIBzpP
	 UEbXdiKKMd8xYohzrb7cOBQ4WBjc8uHra3loDvCLg7JqA32pSj+6cb6N5LY7y2uiI8oDj+iz3Ft8
	 nyz2FFBOtAeCospc5YOQZFRbWRrFziSpTSr/kCw7BJ78J0msNmCcck6vZUiZySzlY573GttrRAzr
	 qo6XrY69csdn2qurM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <4a24a8b7-4ccc-4cfc-ac79-e60710e7814d@qq.com>
Date: Mon, 29 Jun 2026 02:48:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] minix: convert address space operations to iomap
To: Jeremy Bingham <jbingham@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, jkoolstra@xs4all.nl
References: <cover.1782422707.git.jbingham@gmail.com>
 <253660638c14057720cdcafe7d1ca2828457caa1.1782422707.git.jbingham@gmail.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <253660638c14057720cdcafe7d1ca2828457caa1.1782422707.git.jbingham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jeremy,

I came across the Sashiko AI review of this patch series and reproduced
one of the issues it flagged -- a NULL pointer dereference when creating
a symlink on a mounted minix filesystem. The crash is deterministic and
triggers on the first symlink() call.

The Sashiko review page is at:
https://sashiko.dev/#/patchset/cover.1782422707.git.jbingham@gmail.com

 > @@ -487,19 +540,36 @@ static int minix_write_begin(...)
 >  }
 >
 >  static const struct address_space_operations minix_aops = {
 > -    .dirty_folio    = block_dirty_folio,
 > -    .invalidate_folio = block_invalidate_folio,
 > +    .dirty_folio    = iomap_dirty_folio,
 > +    .invalidate_folio = iomap_invalidate_folio,
 >      .read_folio = minix_read_folio,
 > +    .readahead = minix_readahead,
 >      .writepages = minix_writepages,
 > +    .migrate_folio = filemap_migrate_folio,
 > +    .bmap = minix_bmap,
 > +    .is_partially_uptodate = iomap_is_partially_uptodate,
 > +    .release_folio = iomap_release_folio,
 > +    .error_remove_folio = generic_error_remove_folio,
 > +};

The iomap conversion removes .write_begin and .write_end from
minix_aops.  They are now only present in minix_dir_aops (the new
directory-specific aops).  However, minix_set_inode() still assigns
minix_aops (without write_begin) to symlink inodes:

In minix_set_inode() (unchanged by this patch):
```c
         } else if (S_ISLNK(inode->i_mode)) {
                 inode->i_op = &minix_symlink_inode_operations;
                 inode_nohighmem(inode);
                 inode->i_mapping->a_ops = &minix_aops;
```

When a user calls symlink() on a mounted minix filesystem,
minix_symlink() calls page_symlink(), which directly dereferences
aops->write_begin:

In page_symlink() (fs/namei.c):
```c
         err = aops->write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
```

Since minix_aops.write_begin is now NULL, the kernel tries to execute
code at address 0x0.

--- Reproduction ---

Kernel: 7.1.0-next-20260625-g085406171f0d #1 SMP PREEMPT(full)
Config: CONFIG_MINIX_FS=y, CONFIG_BLOCK=y, CONFIG_KASAN=y
QEMU:   QEMU Standard PC (Q35 + ICH9, 2009)

The trigger is deterministic -- no fault injection or race conditions
required. Simply mount a minix filesystem and create a symlink.

--- Crash Log ---

[  331.105013][ T9804] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[  331.106761][ T9804] #PF: supervisor instruction fetch in kernel mode
[  331.107911][ T9804] #PF: error_code(0x0010) - not-present page
[  331.109704][ T9804] Oops: Oops: 0010 [#1] SMP KASAN NOPTI
[  331.110760][ T9804] CPU: 1 UID: 0 PID: 9804 Comm: poc Not tainted 
7.1.0-next-20260625-g085406171f0d #1 PREEMPT(full)
[  331.111754][ T9804] Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  331.112105][ T9804] RIP: 0010:0x0
[  331.112831][ T9804] Code: Unable to access opcode bytes at 
0xffffffffffffffd6.
[  331.119688][ T9804] Call Trace:
[  331.120018][ T9804]  <TASK>
[  331.120309][ T9804]  page_symlink+0x394/0x4c0
[  331.120772][ T9804]  ? __pfx_page_symlink+0x10/0x10
[  331.121270][ T9804]  ? minix_new_inode+0x3bf/0x510
[  331.121772][ T9804]  minix_symlink+0xd8/0x180
[  331.122717][ T9804]  vfs_symlink+0x17d/0x4e0
[  331.123171][ T9804]  filename_symlinkat+0x3ab/0x4e0
[  331.124745][ T9804]  __x64_sys_symlink+0x7e/0xb0
[  331.125200][ T9804]  do_syscall_64+0x129/0x880
[  331.125700][ T9804]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  331.126200][ T9804] RIP: 0033:0x41c13b
[  331.126700][ T9804]  </TASK>
[  331.127200][ T9804] Kernel panic - not syncing: Fatal exception

The RIP at 0x0 confirms a NULL function pointer dereference.
The call chain is exactly page_symlink -> minix_symlink -> vfs_symlink.

--- PoC ---

Build:  gcc -o poc poc.c -static
Run:    ./poc         (requires root for mount/loop setup)

/*
  * PoC: NULL pointer dereference in page_symlink() when creating a
  * symlink on a minix filesystem.
  *
  * The patch removed .write_begin from minix_aops during the iomap
  * conversion, but symlink inodes still use minix_aops. page_symlink()
  * dereferences the NULL function pointer.
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/wait.h>

#define MINIX_IMAGE "/tmp/minix_test.img"
#define MINIX_MOUNT "/tmp/minix_mount"
#define LOOP_DEV    "/dev/loop0"
#define IMAGE_SIZE  (1024 * 1024)

int main(void)
{
     int fd;
     char buf[IMAGE_SIZE];
     pid_t pid;
     int status;

     if (geteuid() != 0) {
         fprintf(stderr, "This PoC requires root privileges.\n");
         return 1;
     }

     mkdir(MINIX_MOUNT, 0755);

     /* Create and format a minix v1 filesystem image */
     printf("Creating minix filesystem image...\n");
     memset(buf, 0, sizeof(buf));
     fd = open(MINIX_IMAGE, O_CREAT | O_RDWR | O_TRUNC, 0644);
     if (fd < 0) { perror("open image"); return 1; }
     write(fd, buf, sizeof(buf));
     close(fd);

     pid = fork();
     if (pid == 0) {
         execlp("mkfs.minix", "mkfs.minix", "-1", MINIX_IMAGE, NULL);
         perror("mkfs.minix"); _exit(1);
     }
     waitpid(pid, &status, 0);
     if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
         fprintf(stderr, "mkfs.minix failed\n");
         unlink(MINIX_IMAGE); return 1;
     }

     /* Set up loop device and mount */
     printf("Setting up loop device and mounting...\n");
     pid = fork();
     if (pid == 0) {
         execlp("losetup", "losetup", LOOP_DEV, MINIX_IMAGE, NULL);
         _exit(1);
     }
     waitpid(pid, &status, 0);

     if (mount(LOOP_DEV, MINIX_MOUNT, "minix", 0, NULL) < 0) {
         perror("mount");
         pid = fork();
         if (pid == 0) { execlp("losetup", "losetup", "-d", LOOP_DEV, 
NULL); _exit(1); }
         waitpid(pid, &status, 0);
         unlink(MINIX_IMAGE); return 1;
     }

     /*
      * TRIGGER: symlink() -> minix_symlink() -> page_symlink()
      * -> aops->write_begin(NULL, ...) -> NULL deref -> RIP 0x0
      */
     printf("Creating symlink to trigger NULL dereference...\n");
     symlink("/this/is/a/test/symlink/target", MINIX_MOUNT "/mylink");

     /* Cleanup (unreachable if kernel panicked) */
     umount2(MINIX_MOUNT, MNT_DETACH);
     pid = fork();
     if (pid == 0) { execlp("losetup", "losetup", "-d", LOOP_DEV, NULL); 
_exit(1); }
     waitpid(pid, &status, 0);
     unlink(MINIX_IMAGE);

     printf("PoC completed. Check dmesg for crash evidence.\n");
     return 0;
}

I see you already have test patches via the syzbot test infrastructure
that add write_begin/write_end back to minix_aops -- great!  This PoC
can serve as a concrete reproducer to verify the fix.

Thanks,
Xiao


