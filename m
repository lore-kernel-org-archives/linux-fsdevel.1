Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E5392C2F;
	Tue, 28 Apr 2026 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343859; cv=none; b=qDq8QNzlnpt8YwV5nJ0sV/dE1qsUA+5tlrM7I9jhxHLMQ4GU3jNLo3o9akTVBi9rps7izugYRN4PKum3aeHOpT5NPT4QXCKpxw02ikSNied/2ehOefNA39JhPWTMQD5Y2Ju7Aw5FwkgUtNuevfgSp28sghIHSxtnnqRpNK8e7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343859; c=relaxed/simple;
	bh=45H8MTsBPReQ4m1IV4CQokbkzjyqAw91hi3MnXz+FO8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z0N/fv6kzPKN8CAqUiOP6kG+yXx2smyM27u5dX57eXxCdwYXPz/qxnWiwn11TM308ERkBMU2DM9Awj4SkPXyY8G6B6o0sYL2ILdO6tyL0/GdvPO4+I6PIu+EXmiagTJyRnUZ6I0GE3bJwX7JCzGcaAHvjiTU1WNGAaDvisqQ8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jA4LS1MB; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jA4LS1MB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777343850; bh=WLhWSfcx/PJyCpxEm0wlVtmU0n2dQqT54ad8Bmx2+n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jA4LS1MBdzfcYa8Xo9oea8Ly+Ni58AQHghuuILdOqP+vz4a5qQOXttqiTY6nnwknv
	 ibtnkn0YmRk+qI67PM27TBlu7z75ZzObChLGlSntYkgFBHIzbZr1+Zlwhr43e7i9Nz
	 cUfVRvZnzYdlv7TJEu85Pd1NQYCizPCUFRenc5EI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 95AB2A6E; Tue, 28 Apr 2026 10:37:26 +0800
X-QQ-mid: xmsmtpt1777343846tfmzkfeq3
Message-ID: <tencent_E61C2526BAF4BB9C33139E9E1B3A4BBA1B08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5HkqrhEAx1xU7zVoHdFhzUw1QXhaopUBiakBtLwNUF/J0bqSlYe
	 6nBx0T1oLp/GqeAr8ROlN95ctRMNDq11v9GEmImpMkOuDtPkysX+nq37M2IUvjDwoLxd9CCA9SZx
	 mHmmI+kQf+3l9nf//iueazB98Na+/7Yua0I1/mRrJx0lPKEoxX0RTxbG0YB79dhvBtq/Vc+sLHsF
	 p/biQ8D86FFChFtoPZADqZ2NIQzyRcP/60s6P88jpYHtVn8eRAtWSwue4qWmQAjslu4jNf0ATaO+
	 DIaRR024R305fJWtDobJNZO+puXQUyB7Uz9+C9k9hSIhXgknDV+gtrPpvi+VTJSw4OlJ+2ecQ/70
	 t2XCAQFNDNI7cd+lo+f5bE1OeAvEpm61ks7mmWjMolIQ8McgQ2AxPbeH5eEvBwODYC4dsZO/NylO
	 F9GQgnmLvJcnt02mT61sjPlFzWZanv4VfAyiaxWWQch5nbmfrUxDs86ZP8FOy1rPXFzdrzyILA16
	 LtwRgZY4oF8bN0Gr3nL/V0Ey3roXn8zqGlVN0AiHHlQAi5O9SwyU/FhEK9Lr9boz+0YH1YXDDdF5
	 GDXxQVtN5wi/Wb8NaJSmJ0fCxiEWYnWH/Nl+TQr20OIkKaK/jSKKA+ow65Dc+tZxVFu/7nA6fEbC
	 KdCq9tKbdoHKHjiNDHWSycBLfVhUNpf0O+Vg2gvfvSwPz4kErdrwsSTbV0RTV7zwCCHQJJKIZaOq
	 2vt6Dogw3ZLikWEn6UYI3DVAa6cySeS/5/v26WTnN4g0IX88qP0CxvD6UaBFwQoI0ty1S+AjlTno
	 kzg5rTvrG7IzhJMvSwlnZll1TPUhooLzOYGZDIjATAuhNR74dPzz0rbZ5q4mgQqH5t87I7mdXJV3
	 RKhy67jVeCRg9MUztAkZGJK96GYIYT9ZETMHNHL/RAe/uN2HjaTWOF5/wv7bliTWAH0AcZ/6+TIF
	 2L7mFOUblCiET3i2KW8omdOipTMkAGkYPQfuY6fUlkYJslNOLqtTDo5y43cZczT2mxBN6uolJTCP
	 Euewsvng==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
Subject: Re: [PATCH] hfsplus: Supports freeing newly created tree head
Date: Tue, 28 Apr 2026 10:37:27 +0800
X-OQ-MSGID: <20260428023726.231215-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <39b283f4e3fe75a8b9ee324e5906c6635aafed40.camel@redhat.com>
References: <39b283f4e3fe75a8b9ee324e5906c6635aafed40.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Viacheslav Dubeyko,
Apologies for the late reply.

On Wed, 22 Apr 2026 11:19:10 -0700, Viacheslav Dubeyko wrote:
> On Sat, 2026-04-18 at 17:37 +0800, Edward Adam Davis wrote:
> > On Fri, 17 Apr 2026 15:03:17 -0700, Viacheslav Dubeyko wrote:
> > > > hfs_bnode_put() does not support deallocating a newly created btree
> > > > head node; therefore, regardless of whether hfsplus_bnode_find() succeeds
> > > > or fails, it cannot effectively reclaim the memory allocated for a newly
> > > > created head node.
> > > >
> > > > When finding a head node, if the node is a newly created one, we can use
> > > > hfs_bnode_free() to reclaim its memory.
> > > >
> > > > [1]
> > > > BUG: memory leak
> > > > unreferenced object 0xffff88811cabc840 (size 96):
> > > >   backtrace (crc 3e2dadb7):
> > > >     __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
> > > >     hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
> > > >     hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
> > > >     hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548
> > >
> > > I need slightly more detailed and clear explanation how the issue has been
> > > happened and why we need to fix it in a such way. Currently, I don't have the
> > > complete picture how this happened. I am sure that you have the complete
> > > picture. :) Could you please share what you have in your mind? :) Don't hide the
> > > wisdom. ;)
> >     fc_mount()
> >      vfs_get_tree()
> >       get_tree_bdev_flags()
> >        hfsplus_fill_super()
> 
> We have multiple calls of hfsplus_btree_open(). Which particular b-tree do you
> mean here?
> 
> >         hfsplus_btree_open()
> 
> I assume that you mean hfs_btree_open().
> 
> >          hfsplus_bnode_find(tree, HFSPLUS_TREE_HEAD)
> >
> 
> We call hfs_bnode_find() here.
> 
> >
> >           __hfs_bnode_create()
> > 	   ...
> > 	   node->this = cnid; // cnid is HFSPLUS_TREE_HEAD, it is 0
> > 	   ...
> > 	  ...
> > 	  desc = (struct hfs_bnode_desc *)(kmap_local_page(node->page[0])
> > 	  node->type = desc->type;
> > 	  switch (node->type) {
> > 	  ...
> > 	  default:  // because node->type is 127, so run here
Following "default," the comment I added clearly indicates that the
issue stems from the `type` value being 127.
> > 	  	goto node_error;
> 
> I think, maybe, we need to add some error message(s) when some error is
> happened. What do you think?
> 
> > 	  ...
> > 	  hfs_bnode_put()
> > 	   ...
> > 	   if (test_bit(HFS_BNODE_DELETED, &node->flags)) { /* head node not set HFS_BNODE_DELETED flag
> > 							     * so, the node will never be freed.
> > 							     * Furthermore, even if the node were marked
> > 							     * with the HFS_BNODE_DELETED flag, hfs_bmap_free()
> > 							     * would still trigger BUG_ON(!node->this).
Please note the comments I added above.
> > 	   						     */
> 
>  node_error:
>  	set_bit(HFS_BNODE_ERROR, &node->flags);
> -	clear_bit(HFS_BNODE_NEW, &node->flags);
> -	wake_up(&node->lock_wq);
> +	if (num != HFSPLUS_TREE_HEAD) {
> 
> Why do we need to distinguish is it HFSPLUS_TREE_HEAD or not? I don't see any
> difference in node processing.
> 
> +		clear_bit(HFS_BNODE_NEW, &node->flags);
> 
> I think that we don't need to clear the HFS_BNODE_NEW. Because, we need to
> analyze HFS_BNODE_ERROR in hfs_bnode_put().
> 
> +		wake_up(&node->lock_wq);
> 
> I assume that wake_up() should be called anyway. Why have you removed this call
> for HFSPLUS_TREE_HEAD case?
Based on my analysis, hfs_bnode_find() does not support searching for
HFSPLUS_TREE_HEAD.
> 
> +	}
>  	hfs_bnode_put(node);
>  	return ERR_PTR(-EIO);
> 
> @@ -694,6 +698,10 @@ void hfs_bnode_put(struct hfs_bnode *node)
>  			hfs_bnode_free(node);
>  			return;
>  		}
> +		if (test_bit(HFS_BNODE_NEW, &node->flags)) {
> 
> I suggest to analyze HFS_BNODE_ERROR here.
Only the new head node will reach this point, no further analysis is
required.
> 
> +			hfs_bnode_unhash(node);
> +			hfs_bnode_free(node);
> +		}
> 
> @@ -598,14 +598,18 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree,
> u32 num)
>  		if (key_size >= entry_size || key_size & 1)
>  			goto node_error;
>  	}
> -	clear_bit(HFS_BNODE_NEW, &node->flags);
> -	wake_up(&node->lock_wq);
> +	if (num != HFSPLUS_TREE_HEAD) {
> +		clear_bit(HFS_BNODE_NEW, &node->flags);
> +		wake_up(&node->lock_wq);
> 
> What the point in this code? Why have you change the logic here?
To support tree head.
> 
> +	}
>  	return node;
> 
> And, could you please add these new details into the commit message?
OK.

Edward
BR

