Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC085477E
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911860; cv=none; b=qfNdTDUOGdzh/yUNWW5MhIaf5n6NdrAy5qagmC9xA08Iok/TkgZziChGdjF52nGDaDymtoi+5T/HlDZxUlIzEcXfcNcxNI9alelBTrQR5cfCon6qeAD6ffY3u+DHmnG8ibsTFIWoMiderUvBuuGz/t8RfCRWC7ByiD3oA1MfuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911860; c=relaxed/simple;
	bh=LLUfIhGvdHPDlemXvXn6kgdGVWfCxG3Ve59URcgtbZM=;
	h=To:cc:From:Subject:Date:Message-ID; b=sMQoGHijiSJJgNOupNk4i2Rbyg/lwYz2f1ad9KMVHxaPmEHqOAgE0lysjk8m5XJZoEPWKsp25UnR4M79djoKxzSYJ/aFP7KoHB4l00rVxibndGdvpOU3KqbLF2xQ2cIs0EMp250QuMsQFQEENXKPVTnXvI3YS5PSQnTNWq1F284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=EZYufocB; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="EZYufocB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dh5+phe4Dk/SwXwBg4F0iA2usYKu/WYz/hM0RWEWFP8=; t=1786911858; x=1787775858; 
	b=EZYufocBcBSCWqrkJkBlUOeG6DKU4NFihiNAQIgHVABxKsxsVWNrURP+s3DYw3IrXzckhpA+dL6
	XQ/aXLXeB88/lQtWi4k+R1kGKK45gxpW0Dr77UajEwlGIUrhAlrnEewg+Kz243aaKkXLphQnFw86B
	U7KLhvMO2SYJaHmxjklnpgJql3kHyqF+R8r5T8wTGjrQs7VikSFR6G8GvkS9ytzlCXxg6myaorGwt
	ePL+p+mUuv24/2OIYcxCeYzVHMi5ugYQmjy9HbI+lgT6wNJlXSsJ6OwWJ2uP0wy+a2qwsYtxvfxgU
	Vuf1d0qQqOraX9AyqTz7wz3I47Om/CGFZzAg==;
Received: from c-24-60-177-128.hsd1.ma.comcast.net ([24.60.177.128] helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1wvhOy-0060UC-Ja;
	Sun, 16 Aug 2026 16:24:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id CC2D13BC7C52;
	Sun, 16 Aug 2026 16:24:15 -0400 (EDT)
To: Namjae Jeon <linkinjeon@kernel.org>,
    Hyunchul Lee <hyc.lee@gmail.com>
cc: linux-fsdevel@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: ntfs_inode_attr_pread(pos<0) can dereference bad pointer
Date: Sun, 16 Aug 2026 16:24:15 -0400
Message-ID: <16859.1786911855@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

ntfs_inode_attr_pread()'s check on its pos argument is

        if (pos > isize) {
                mutex_unlock(&ni->mrec_lock);
                return -EINVAL;
        }

which allows pos to be negative, allowing this to potentially read from
a wild pointer:

                memcpy(buf, (u8 *)attr + pos, count);

A demo using a corrupt NTFS image:

# uname -a
Linux xxx 7.2.0-rc7-00016-g3d6d817622b0 #40 SMP PREEMPT_DYNAMIC Wed Aug 12 13:01:40 EDT 2026 x86_64 x86_64 x86_64 GNU/Linux
# wget http://www.rtmrtm.org/rtm/ntfs23d.img.gz
# gunzip ntfs23d.img.gz
# mount -t ntfs -o loop,rw junk /mnt
# ls /mnt
ntfs: (device loop0): ntfs_lookup_inode_by_name(): Corrupt directory.  Aborting lookup.
Oops: general protection fault, probably for non-canonical address 0x7fff88c0c159a850: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 3 UID: 0 PID: 1273 Comm: ls Not tainted 7.2.0-rc7-00016-g3d6d817622b0 #40 PREEMPT(full)
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
Call Trace:
 <TASK>
 ? ntfs_inode_attr_pread+0x26d/0x2f0
 ? __kvmalloc_node_noprof+0x1f0/0x5b0
 ntfs_ib_read+0x3d/0xd0
 ntfs_index_walk_down+0x76/0x120
 ntfs_readdir+0x7e5/0xa60
 ? selinux_file_permission+0x127/0x190
 iterate_dir+0x91/0x150
 __x64_sys_getdents64+0x77/0x110
 ? __pfx_filldir64+0x10/0x10
 x64_sys_call+0xfd0/0x2130

Robert Morris
rtm@mit.edu

