Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B413BB9F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000612; cv=none; b=tItZoWsLImjrBamv1RqZZBCf7tl6+FU8I9jrzUTZVCfCmTeRyL1iBALmDG6CDOGmEm2r2VjQOHtJgKio1bOB832H5dPnl/ieVH4vqBHX5A6mGruva1NQk0KKU7Igx30rvC1/e2uNFJeNM8+GlmmM1g7/xftFjMayZ3aFwUK6iYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000612; c=relaxed/simple;
	bh=69DXk+VtCO3kehOymY6MxH6DAO1fCp4InXRViuaavpw=;
	h=To:cc:From:Subject:Date:Message-ID; b=eyEREcupj2WfRp9IpSMbzTOflZl4mr8N3OX73OxgtN59mvO0aeP7icimwtTPk604Qe8lyQTKOh9BVGucoQTNfp+gJjfhZoZgYLvh9Rem1zQzJu2NHiAlSq7nURZwpRRSD35XfMvj42gHvwG5kqwx+OPQcz1beNsX2u73XTGaj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=X4YScpjP; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="X4YScpjP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4jsYg3/xEnJJ+oSCXYhPbWcRugOn8Fy/+jmYtnKiC5g=; t=1787000611; x=1787864611; 
	b=X4YScpjPP815x15GUEHrTtxMtzvE9PBn1pqn2U/ej/jcQWkmBlvzUTczkoenjivoMb68F+bDEGN
	W2m/PrurHtKrwegKhETaTfqSKdlHDM+9aqHy+SSI9e93qZyWRGuhc3bpMfR3CSUUTYqq+CMlLcBuB
	pHEoon2Y1Cn2OBA9VDMGYUx8YiHLb5td8vwRUdqC7+UUSCQOxxV7uz7Y9edauyCpTt72Js1rQdkEN
	Eegk+Z4JilBdNYsUhD7g62LDqrNgBpTNnjFCN27XwKG1jyaJvAO41PynHI0kzoSycpmUUGfx9d5Fs
	GST4KTpKS5S7Uy9MYVi36PeGK3vIco2eiHTA==;
Received: from c-24-60-177-128.hsd1.ma.comcast.net ([24.60.177.128] helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1ww4UN-00AJBF-RE;
	Mon, 17 Aug 2026 17:03:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id E7CC93BD01F6;
	Mon, 17 Aug 2026 17:03:22 -0400 (EDT)
To: Namjae Jeon <linkinjeon@kernel.org>,
    Hyunchul Lee <hyc.lee@gmail.com>
cc: linux-fsdevel@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: a negative ntfs superblock mft_lcn can cause a wild memory reference
Date: Mon, 17 Aug 2026 17:03:22 -0400
Message-ID: <57514.1787000602@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

If the ntfs superblock's mft_lcn is negative, that will pass tests
such as

        ll = le64_to_cpu(b->mft_lcn);
        if (ll >= vol->nr_clusters) {

and 

        vol->mft_zone_end = vol->mft_lcn + mft_zone_size;
        while (vol->mft_zone_end >= vol->nr_clusters) {

because the variables are signed.

The attached corrupt NTFS image exploits this to cause index to be
out of bounds in ntfs_cluster_alloc(), e.g. for

                if (vol->lcn_empty_bits_per_page[index] == 0)
                        goto next_bmp_pos;

index is derived from mft_lcn via mft_zone_end, data1_zone_pos,
zone_start, and bmp_pos.

# wget http://www.rtmrtm.org/rtm/ntfs8b.img.gz
# gunzip ntfs8b.img.gz
# cp ntfs8b.img junk
# mount -t ntfs -o loop junk /mnt
# echo x > /mnt/x
ntfs: (device loop0): check_mft_mirror(): $MFT and $MFTMirr record 0 do not match.  Run chkdsk.
BUG: unable to handle page fault for address: ffff80010e38ef58
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 10 UID: 0 PID: 1264 Comm: tcsh Not tainted 7.2.0-rc7-00016-g3d6d817622b0 #40 PREEMPT(full)
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:ntfs_cluster_alloc+0x376/0x12a0
Call Trace:
 <TASK>
 ? inode_io_list_move_locked+0xa1/0xe0
 ? folio_mark_dirty+0x33/0x60
 ntfs_mft_data_extend_allocation_nolock+0x15b/0xa30
 ntfs_mft_record_alloc+0x921/0x1790
 __ntfs_create+0x1c4/0xd40
 ? ntfs_attr_put_search_ctx+0x3b/0x50
 ? kmem_cache_free+0x207/0x2f0
 ? __mark_inode_dirty+0x16a/0x3b0
 ntfs_create+0xc1/0x170
 path_openat+0xfe0/0x12f0
 ? do_syscall_64+0xf9/0x540
 ? do_getname+0x2e/0x180
 do_file_open+0xdf/0x1a0
 do_sys_openat2+0x79/0xe0
 __x64_sys_creat+0x49/0x70
 x64_sys_call+0x1bfa/0x2130
 do_syscall_64+0xf9/0x540
 ? exc_page_fault+0x76/0x130
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Robert Morris
rtm@mit.edu

