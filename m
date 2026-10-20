Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493543;
	b=3tr7nLwk5keyux3by0JUQU7/K5/zpmXUnKfgWMdyl6phhofSJzhMah5IwFfo5enNTvvF
	 nNjxiBL5rwans3v2u1yOGCLyyayB48aHr/T6olTPXtevkSUts8pMiIFYwA485KnvBJOqB
	 xMITCC/ifcCAJ9ZuAc0Hr0bDegHpdw27/+JoDNuDUK3usfW6jlued4YX/agvJ0r1FMoFw
	 F9ZqbzeLccXG2NxtitqRWtqR0mPPBzss5tVTGtHMoBoJ1us1zPr/3+Q6kbq0NpPM9ArFQ
	 o9AS3AKXzi0kUOPOtniCJDWz+oPoKYBQ2Vj/dm5M/jLdTljGrYh1o22xMUBVgu5Prww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493543;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZHZs513fUIH8Uh9joScZ6/li+ZcM7NQZlH6DFjNrec4=;
	b=QUnP0/P+ADZJFlZsTnDTeDq9QsOj9ix62bzcknfk4Hpelf4n6VD4T3C2uFSIlbhpQau7
	 eSP4sHEyu8Ex2eTE/48eJdf8eGFf8O25VnNCv1d3+Aab/XvmjPty6oQRpZv3HKgO2yFyw
	 AXe/Bf36t6NUT6VfncuCFqDRf2YZF8T1J6HQhVFnDmVnLSVNqnVTjgd5U47aOIkxOxvax
	 xomTlF6+tMscsAeo/upwiesbeWQOlucW5YUrVkS4fM6uOtzi/Gcch/+ORhkNeS0vPJd+P
	 PId+eMn7GdvqaZyuhPDhfGS75WvKO2gbqrIpdWnSE3ZqIInVigF2lSDPhjSzUwmy/EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FHHMHqTc;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E2606A32C;
	Tue, 20 Oct 2026 10:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10E2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FHHMHqTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792493539; bh=ZHZs513fUIH8Uh9joScZ6/li+ZcM7NQZlH6DFjNrec4=;
	h=From:To:Cc:Subject:Date;
	b=FHHMHqTc1K0mCfLO5Q+LueN+bAa65w8XhaI604sqByc9TLD8mmccWUZjj1OUI/Bxq
	 XakUSdR+FkOPIrNjHVaacRB3oLcIcCCqdaDmLm307yMzvN+dZo6FeIu8XK51sp5ihj
	 /qpPVjL9VeBu17tXboLOHSFZ7FfjdrW+uJ8Qp1dk=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D11BFAC6; Tue, 20 Oct 2026 18:52:17 +0800
X-QQ-mid: xmsmtpt1792493537t9gdwfo3y
Message-ID: <tencent_EC9DEFBD1157A73B5394A8051F96A8EE5407@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uhmQXXZDmt6BBCcw6fGYvSk87KgIqABlqe4Wz0JLsntHAGFW5jo
	 8iq/PcSgyU7AfTo3mN5MKPJ4f6g65c1W0PMkrtjZQ+1wc6l6BhEug1AU+J9BUZLuwVPHu2YU5bO2
	 doiIo8WVRLPJUXFZmm17aKZQf/nl8IyKZVCOh6iUL2NG53xa6614BKqQ6P0zHgjnAP/HyAzH5KgR
	 OM5VPxnkuQVEWk93pgIcxnnnS4RCzBS1R/TKvT0wSk+Od6xtFEhpbKzScFxvGlA3kzK8E+Mk9N6T
	 cissvt1oGVQ2E8QkiIK8ukHqD+Bdl03xvLvk4hX73NL3w4uBuIJy0vG13h6mZhqnHfgi2c4AyobW
	 OftSa8MiK5Of23Pq/SWIERp7dRrVujFXxLlo6ITmPpkepoVLY4RMhdd2Xk2+QvJBQwBTnPCJl9m0
	 yB1BrYOJhvQGXWrBQsPTIRge+68O/D3NiZBi+LdlGakpiv0sUHMaZfqL33vMU/XGghMk2om/WYBE
	 f2xY/SbgBxRp+zl3TCPIzUnucaUAG5tAGhSeeq4ABiVMIsYs4AHgksG2ZdE18mW9sAI+FBNB5IZP
	 o63YGVUAC6eg0vEAhjnj13wB0BZpoxFy7STnnVlbXJhbPnse/aHTgOr7kWuS7bphS08EufTVDtrZ
	 czn49GRLjcDdiaPgGfgxbNe79JmtUe6IbU14LX3iuIVhwqdfMkoimfvNLw3JUD8xfS1Cw6SGJCK8
	 okfWJMSEBozMxiHc03Cctt97zLDYS1nHM16oMII3e2UIMROfPFiwzjak9oFS+9WbNlunlw7yJU5U
	 eKLGeIrn5cynsukDl6Zkx3JiLwEhhCOb9Uz8HJD2X+qFVs0VEkbeCOEJ07wraHN/48gRK8vqbdZh
	 aEWF21V7uy2C1+KUH1YCNhoOPX82LB/ze9Y+aFt87mx2RVqf4vpTvaz666TBzWGPWezEGZnolxR5
	 PI/DzHaeA0qzNozbZCB79N9oT40epcgDR9uC0jxdR25hUjYF06qGXuJ8TUUJZizh4DslAyOc2FsG
	 7gP6fvDx7SBlW4eW7BwJeBwes2mlgnsO74MpRnT8T/VTs0FD22tFFXgkxqkEdD0j4JjcOHHkmXrH
	 qgzY44
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fs/ntfs3: fix log replay index walkers running past the entry chain
Date: Tue, 20 Oct 2026 18:52:16 +0800
X-OQ-MSGID: <20261020185216.37136-ntfs3-yangguikun19@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_if_root_index() and check_if_alloc_index() walk the directory
entry chain of an index header until the walk offset reaches
lrh->attr_off.  They only re-check the buffer boundary at the top of
each iteration, and they do not stop at the NTFS_IE_LAST entry that
check_index_header() treats as the end of the validated chain.

The gap between the end of the validated chain and hdr->used is inside
the buffer but is never validated as directory entries.  A crafted
$LogFile can place a size field there that jumps the walk straight to
an attr_off far outside the buffer, and the walker then reports
success.

The callers treat that result as "attr_off names a valid entry":

  - SetIndexEntryVcnRoot/Allocation write the 8-byte log payload at
    attr/ib + attr_off,
  - AddIndexEntry* compute PtrOffset(e1, hdr + used) with e1 beyond
    that point, which underflows to a huge length,
  - Update/DeleteIndexEntry* read entry fields at the same offset.

Mounting such an image read-write therefore performs an out-of-bounds
write of controlled data at a controlled offset while replaying the
log.

Observed on v6.6.12 with KASAN (kasan_multi_shot=1), mounting the
crafted image read-write:

  BUG: KASAN: slab-out-of-bounds in log_replay+0x9744/0xe850
  Write of size 8 at addr ffff88804b097f40 by task mount/8065
  Call Trace:
   kasan_report
   log_replay
   ntfs_loadlog_and_replay
   ntfs_fill_super

  The buggy address belongs to the object at ffff88804b097f00
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes to the right of
   allocated 64-byte region [ffff88804b097f00, ffff88804b097f40)

  Allocated by task 8065:
   kmemdup
   log_replay+0x55bf/0xe850

The write repeats at consecutive addresses while the same log record
is replayed; 54 reports were collected in a single mount.  Without
KASAN there is no message and the mount appears to succeed.

Stop the walk at the NTFS_IE_LAST entry so the landing offset can no
longer be driven past the end of the validated chain.

Tested on v6.6.12 and on a v7.3-rc5 based linux-next tree, both with
KASAN: with the crafted image the unpatched kernel reports
slab-out-of-bounds (write of size 8) during mount, while the patched
kernel rejects the record ("failed to replay log file. Can't mount
rw!") and no KASAN report is produced.  An ordinary NTFS image still
mounts read-write, accepts writes and is readable after remount.

The image is 63 MiB (197 KiB gzipped).  I can send it if you want to
reproduce it, or it can be regenerated: the crafted image only rewrites
the root directory index record and the $LogFile restart area of a stock
NTFS volume created with mkntfs -s 512 -c 4096.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/ntfs3/fslog.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2956,6 +2956,7 @@ static inline bool check_if_root_index(const struct ATTRIB *attr,
 
 	while (o < ao) {
 		u16 esize;
+		bool last;
 
 		if (o >= asize)
 			break;
@@ -2964,8 +2965,13 @@ static inline bool check_if_root_index(const struct ATTRIB *attr,
 		if (!esize)
 			break;
 
+		last = de_is_last(e);
+
 		o += esize;
 		e = Add2Ptr(e, esize);
+
+		if (last)
+			break;
 	}
 
 	return o == ao;
@@ -2981,6 +2987,7 @@ static inline bool check_if_alloc_index(const struct INDEX_HDR *hdr,
 
 	while (o < attr_off) {
 		u16 esize;
+		bool last;
 
 		if (de_off >= used)
 			break;
@@ -2989,9 +2996,14 @@ static inline bool check_if_alloc_index(const struct INDEX_HDR *hdr,
 		if (!esize)
 			break;
 
+		last = de_is_last(e);
+
 		o += esize;
 		de_off += esize;
 		e = Add2Ptr(e, esize);
+
+		if (last)
+			break;
 	}
 
 	return o == attr_off;
-- 
2.39.5

