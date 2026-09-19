Received: from sv14987.xserver.jp (sv14987.xserver.jp [162.43.101.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EC78F2B;
	Sat, 19 Sep 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.43.101.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840071; cv=none; b=pRfNnhyYsKDrLCu0VxGp4RXxwgY7YrMoYOsqie9ilaLCcID9HP1P29wH4hK8uouj6iS7h9Rw0VmBWmOdg0Ihf8hksBygSqGiLsDu7wX2M5x36Pw7y05H6SNGH1BOREsBQPKSGUOVG8OGZDJ2d13JZ+Wwu+r1IGQta+vh9Wu0HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840071; c=relaxed/simple;
	bh=IjtqJVHej9Q7q5narzFGBuBI/BqMfvda4QeRXnnbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tu2GsBSBsz6jsVxsH4PHXJWoWfipFhWTDLfNaoDVggF9uPHPARfkjH4vXoKurOF2V7oQQI9QvF882E42HmuP3NpuTtAvnEyJLDvdvbqBzykv/SdVfy3lN2bxbLdPgGudtaUAFK8auGv5LKMZ80XGcKwHZN4ZVaFIvQi67QVVSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techhowto.blog; spf=pass smtp.mailfrom=techhowto.blog; dkim=pass (2048-bit key) header.d=techhowto.blog header.i=@techhowto.blog header.b=mgb58gvz; arc=none smtp.client-ip=162.43.101.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techhowto.blog
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techhowto.blog
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=techhowto.blog header.i=@techhowto.blog header.b="mgb58gvz"
X-Virus-Status: scanned (With Secure/Atlant/virusgw16020.xserver.jp/)
Received: from claude-vm (KD106155054014.au-net.ne.jp [106.155.54.14])
	by sv14987.xserver.jp (Postfix) with ESMTPSA id 3642FC809E9E67;
	Sun, 20 Sep 2026 02:42:04 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techhowto.blog;
	s=default; t=1789839724;
	bh=nwvPd98bS9S8e7U76fn3jb+OBJKQWrLSgPwMdOvtHzo=;
	h=From:To:Cc:Subject:Date:From;
	b=mgb58gvzR4OL0nd+bGQh26VJYv1beML9XW0CJ38KvpOgOvYTXl8jnoKhHaqI7y6xk
	 oFqi/SNLxNuePf7Kk3LWnnvk0R7cH/a1b4nHrMqCANvgxYQfPm5F+xluW4utqSUPjQ
	 5fa2N4H2YZYyeV1mxwqFlPbMrr2VeaHrt+cI72pSzinjtMMknFq0KLvyoQC9JW7xxH
	 vJt/sO1AtBzmrQXApsRC7kaqJbm+CMLFKXPtttgU0YgRBn6W5Em0kPoIUNBjSwCMO0
	 s35MBH9Izyy9dDeeITNIihz1CxEZsjSTKe8PEXRRVUDnV2UKZKz16KOOVPWYbzBvha
	 mSXTCQioXo00Q==
From: Kentaro Shiomi <k.shiomi@techhowto.blog>
To: Hans de Goede <hansg@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: fix endless write loop and data corruption on short copy
Date: Sun, 20 Sep 2026 02:41:36 +0900
Message-ID: <20260919174136.3325-1-k.shiomi@techhowto.blog>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vboxsf_write_end() ignores the number of bytes that the generic write
path managed to copy into the folio: it initialises nwritten with the
requested length, writes that many bytes to the host and returns the
requested length even when copied == 0.

generic_perform_write() then sees status != 0, so it never calls
fault_in_iov_iter_readable(), advances pos by the full length and loops
again with an iterator that has not been advanced at all.  The result is
an endless loop that keeps appending zeroed data to the file (filling up
the host file system) while flooding the log with

  WARNING: lib/iov_iter.c:624 at iov_iter_revert+0x1fc/0x270

because iov_iter_revert() is called with copied - status, i.e. a
negative value.

The same accounting bug can silently corrupt data: when the folio is
already uptodate, the stale part is not zeroed, so a short copy makes
vboxsf write the old folio contents to the host and report success.

A short copy is not an error condition - it happens whenever the source
pages are not faulted in yet, e.g. when writing directly from an mmap of
another file or from shared memory (virtiofsd does exactly this).

Return the number of bytes that were actually copied, and reject the
write entirely when nothing was copied so that the generic code faults
the source pages in and retries.

Signed-off-by: Kentaro Shiomi <k.shiomi@techhowto.blog>
---
Found while running a nested VM (QEMU/KVM) inside a VirtualBox guest: the
virtiofsd instance exporting a directory that lives on a vboxsf mount writes
straight from the shared guest memory, so the source pages are not faulted in
and every write takes the short-copy path.  Creating a 6-byte text file grew
the file to 29 KB within seconds and a small PNG reached 202 MB before the VM
was killed; the guest ran out of disk space because ~16 GB of logs were
written in the meantime.

Reproduced without virtiofsd or nested virtualisation by writing a few bytes
to a vboxsf file from a PROT_READ mapping (memfd or another file) that has not
been read yet: with the mapping touched first the write succeeds, without it
the write never returns and only dies on SIGKILL.

Tested on Ubuntu 26.04.1 (6.x userspace, kernel 7.0.0-31-generic) as a guest of
VirtualBox 7.2.16 on a Windows host.  With the patch applied, writes from
non-faulted pages, partially copied writes and in-place rewrites all produce
byte-identical files on the host, and the virtiofsd workload completes with no
kernel warnings.

While investigating I also hit an unrelated NULL pointer dereference in
vboxsf_release_sf_handle() when opening a vboxsf file with O_DIRECT; that one
will be reported separately.

A DKMS package with this patch is available at
https://github.com/kentaro-shiomi/virtualbox-vboxsf-endless-write-loop-fix
 fs/vboxsf/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 7a7a3fbb2..1e9f61883 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -307,7 +307,7 @@ static int vboxsf_write_end(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct vboxsf_handle *sf_handle = iocb->ki_filp->private_data;
 	size_t from = offset_in_folio(folio, pos);
-	u32 nwritten = len;
+	u32 nwritten = copied;
 	u8 *buf;
 	int err;
 
@@ -315,6 +315,10 @@ static int vboxsf_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio) && copied < len)
 		folio_zero_range(folio, from + copied, len - copied);
 
+	/* Nothing copied: reject so generic_perform_write() faults in and retries */
+	if (!copied)
+		goto out;
+
 	buf = kmap(&folio->page);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   pos, &nwritten, buf + from);
-- 
2.53.0

