Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4312D2397;
	Sat, 18 Apr 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776505075; cv=none; b=r88AgsqMN0Rf6ZYub+2LJiJABp+79tkQVU0oLGDzGR6wd1c1QvC0FoB/TIIUjmbu372PPsi1SI+mCPR++qJSpvjF4931mtyT+3JtXN7RP0l7tbVRfE8comUbk58L6tJ5byG4pK8wIitGBoPUdELhPOiornwhPwV4M+tC2wy5Vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776505075; c=relaxed/simple;
	bh=2gNCOAMl8rUdDl7dVR3JJfTLo7eh0LnZjDbBTWAHwfw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Dv/OGlRp1l3PiXKPtvrZXCiA9hWnNw3JarK0eZbgmqurz9KxeOItVHHlbsHnmdTXOfp7vL6Hm2gOplHlcxdpbhyprHjU2xGgJt6Bpu/G3L4f7wrs0f8Sy4x7pbFoGf6IqRWLrqYxZb/WJtLLvQK/qT4tjYJZTLj/6+nEYdC+djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oUPqqhZH; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oUPqqhZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776505062; bh=8qBbTia1kqDM3j/n8GXQa67jqWAvqO43BAHpS4mJOxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUPqqhZHFBDHJY6txbgO2QG/dJsZLvZHYEewn7H1TFkvBGMLgpTO/vmnXMS4jrJTq
	 pfJTX4vVNVMvWt+2fO72VZbbjvHGuHr3l1MHM8osac+/yjOwyCuzWeMEtB2bpviZJ1
	 HGof32Vw0CXHCRrN+54v2dEnlDHiv34UV7sbi+kk=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 9678C638; Sat, 18 Apr 2026 17:37:39 +0800
X-QQ-mid: xmsmtpt1776505059t6qnqg7uv
Message-ID: <tencent_B50525C2BA56BB53331B9E5A1B444B281B08@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJP/zUB5xGgLJwlYcLJxncrrMnea7N3g1EImA3hJf41h8RfB9RFg
	 wk1dJBf4iUL49NUxfKPIYyh9Rgauy2CmpUCraK3cIk596oVoRLlOzMr9+agSSaXBao9oVUHmPIMU
	 yC4OvlGBrD9Ac+4viZ9j9j/Zb6O8da2gH85eg/Jj4K9Z4x5I1l57tMB/+8+t7X9pUCCovYrhbmIK
	 svE8aNEV/gkaOF9BpYByf6L4sqBuFuSQhydUMXG55gtTdpLkPaIPCEezImZUpdqdXjizJAaYsnN7
	 mrK26vmSsv2qoEwIBvO84JpdVUCeuXRylK0k1dG5Le5ZlHbDZqGd0psTR6YAeQecC+BKf8Yu9C94
	 esl80PLnreFP9B0DdctQ+PvsoUrsnnIRaCnkry5TcHdjVPXjEOxkfOb3se5Pyo4OhW4L7k5t0Ymy
	 8xPFyrOZyGN48QJy/KZNLk+oeZzxCQpqyX6+F4Q80cU8gWPxSkMiBUnMiQfrNMODE2kb38THLH04
	 RXydQ/jbjWVnUmNLCpytqqGPiUqWUJyd2oXmEG1Qw5T5vVdfLvGBtK6gyQrlEVto8ocjk9m7CZZk
	 ZZo7hsmnNJHXMapBhBF67gE+v4ONvqHhzCCEmLjK/4rQYObVt808cnixLLDvk3zPa08qzFHsQq2t
	 ruFcXKg9tTE9xli/ibPoSZsiwCdLmkmAhSaR3HY5hKBmVGzGTsdzoKQaNpR8yQ/AklFYHdMlWyNi
	 CLL/tyzhVMtHx6mLtGsWfzabnMw3yO8GrS3GiQVfq1wUeyfdbiNx19FfyMRfHLOwksJRIlx5xVtI
	 G+sQBlBnjMT+meMPDRntABv+vCydJ+9bWRVinBf6XlM7Zl0vqksEQ5pKr3jheXqxrYamxUY8l26n
	 42LGK+cfDp8pypCNrdADtn/jikQJ0/7KNPE3pdu7rHz4eVwpsuvqPrtXOevwBMRFuzCsHPY2geGI
	 0ScQy6Wk3SMqT0FWUkH5MNKrlD8O3U+JhSpJNgZFev7wx0516lxDV5N1+FPxA8+mAWdhY+2yYWqP
	 j+d/0hvw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: vdubeyko@redhat.com
Cc: eadavis@qq.com,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: Supports freeing newly created tree head
Date: Sat, 18 Apr 2026 17:37:40 +0800
X-OQ-MSGID: <20260418093739.471318-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <60605973b66496b04c6847ceb6fa46dfada6a628.camel@redhat.com>
References: <60605973b66496b04c6847ceb6fa46dfada6a628.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Apr 2026 15:03:17 -0700, Viacheslav Dubeyko wrote:
> > hfs_bnode_put() does not support deallocating a newly created btree
> > head node; therefore, regardless of whether hfsplus_bnode_find() succeeds
> > or fails, it cannot effectively reclaim the memory allocated for a newly
> > created head node.
> > 
> > When finding a head node, if the node is a newly created one, we can use
> > hfs_bnode_free() to reclaim its memory.
> > 
> > [1]
> > BUG: memory leak
> > unreferenced object 0xffff88811cabc840 (size 96):
> >   backtrace (crc 3e2dadb7):
> >     __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
> >     hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
> >     hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
> >     hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548
> 
> I need slightly more detailed and clear explanation how the issue has been
> happened and why we need to fix it in a such way. Currently, I don't have the
> complete picture how this happened. I am sure that you have the complete
> picture. :) Could you please share what you have in your mind? :) Don't hide the
> wisdom. ;)
    fc_mount()
     vfs_get_tree()
      get_tree_bdev_flags()
       hfsplus_fill_super() 
        hfsplus_btree_open() 
         hfsplus_bnode_find(tree, HFSPLUS_TREE_HEAD) 
          __hfs_bnode_create()
	   ...
	   node->this = cnid; // cnid is HFSPLUS_TREE_HEAD, it is 0
	   ...
	  ...
	  desc = (struct hfs_bnode_desc *)(kmap_local_page(node->page[0])
	  node->type = desc->type;
	  switch (node->type) {
	  ...
	  default:  // because node->type is 127, so run here
	  	goto node_error;
	  ...
	  hfs_bnode_put()
	   ...
	   if (test_bit(HFS_BNODE_DELETED, &node->flags)) { /* head node not set HFS_BNODE_DELETED flag
							     * so, the node will never be freed.
							     * Furthermore, even if the node were marked
							     * with the HFS_BNODE_DELETED flag, hfs_bmap_free()
							     * would still trigger BUG_ON(!node->this).
	   						     */

Edward
BR

