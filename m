Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329343C552C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881959; cv=none; b=LwR+yA9FD0oCom5CC88EDGrNmuoKEHKik7ToSQQjiTolX5OY0RVAhsrtIRn/4riFz7uKUJH6ms2RuM+Uc1ftD7WWJd7FFtzGPRpVyIk/Br5QkOAUjRJwOoT+jIC+msbYs0pErKR+T3kRZA57PmDgU09KNtanMBSiAYxclXP4rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881959; c=relaxed/simple;
	bh=yg0aZU4ZgB3Ms/fU0AljMIkWk9fNOyv4/FX4qzwrF/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxGKDiZQMXNMMNlu/Jmaets3c3jPOyGYo9hZ+HXM6LFPbNYXeOiPa1x2b8rqEd9pdtEF8px4UjPqY85HfqSljs/5WHBAKO7A28uIjNRMwVjz2a9KXBOw4KE91BPatU4NHrCMXeeYi37suSOjZ+hN7xYq/YY+LG3V38souAr/auM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKd4MqPH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=giwJ05CT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKd4MqPH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="giwJ05CT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776881957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwU+V0ShYDgZN9VQw7mFGwyGa9GtIvXJwbt6oc94MqI=;
	b=ZKd4MqPH28oln1hqjswuAUN7AeYVBI92gPgngwhq7FulcC0cU7bqlfEwC/zGZiQQTAOebC
	z4a3k+fjQHe4J8XPzSuPEdjZCtz6JyotWzZ7HocIsZqzn0lrFq75y1aRlX2J+QSPwMkIN+
	y9knE9Dp1FGqms3WR/J3Q5sAXSubm+E=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-lNwShSpHMySnOTEszVvuTg-1; Wed, 22 Apr 2026 14:19:14 -0400
X-MC-Unique: lNwShSpHMySnOTEszVvuTg-1
X-Mimecast-MFC-AGG-ID: lNwShSpHMySnOTEszVvuTg_1776881953
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcc9e6b772so8277412a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776881953; x=1777486753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwU+V0ShYDgZN9VQw7mFGwyGa9GtIvXJwbt6oc94MqI=;
        b=giwJ05CTXeQ+6Lvdoj0jCKRZ6g8SoL1Kw2LVsiJ2cBgvl5iPD4jW0MPATx4dgFKxBH
         1DUz//xxEKU93zODQGO8QlIBpsjyy/tSXYh5gL4FTOC+roRFFwblIFDqoAXsBSm4u1dQ
         /sOZdDZEYZwrcB3A8+lM/o9u2MviNRuvCys3QC7Q1QjjVRN+1YwRHDQ86vP6sE++H6dg
         3PfX2LyIMdvWTy+knzCKMKpuC0dudNm/MxEtvvL6wuE3scUXOV9jbM5dmtibM830uIDq
         MLJO1vFHf++Gk/E08FJiIZy3F9Fuw1QTijeKUO9jiBxU2r9w4YyH5yCv5IvhmTwA5ygI
         v09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881953; x=1777486753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwU+V0ShYDgZN9VQw7mFGwyGa9GtIvXJwbt6oc94MqI=;
        b=E89zh8VMiIVJ7wq3dESuyTMPahjPOd2PEYE5TvYyE3x5khWdpMrYAZg6eudYW1jwjR
         RC5neByn5qMVUGTm6sZnkYy3+e1Qjxb6OGwVLYg08GmLE4oVA0zaHGB9Ip0pBMj/Fly6
         y7x+NRkm/La4FqOyLN3FswJOtD6rSHfZbSuiQBm+XvsS9LjyClTA0FQPU439kxmX2O0x
         s+XIYo9yY4h/r8lXhmEhtW9pN2XXBe73432uQaYVxGpVQm62EhCKR52R/EmQWsEoJg4u
         AfJYl6mWDJ4ARvSei11aKMohL2anYthJUGQF9YtmLujRVEryEmtcrS61pZ4LgAh27IHf
         p7Aw==
X-Forwarded-Encrypted: i=1; AFNElJ93CVUIhEJco8exNls26qcmxHTAdAaJQD6IklXqLm3zUrnyPy4NE129se+wMJqHZyBYT/FfYstYnMcAoLhG@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXz/6E6Ow7UMIbSVeXomWrpXaKNLqye8rOnFE1DFkwLOlCDns
	/SL574Yty8nFYcIuJhBuWH8EdJ9DGsOLUSO0vCPHQ6aSQO0dEUBf5P98LXnQx+wvtlvrwdDIuYS
	9t4grqrGNBNwsOtC1KoDaww6zzoWxjUfZbnXEj/gAzptV4I/2iezkU05kuzJhTrZm6vs=
X-Gm-Gg: AeBDies/QhiIUpjP59B+oMaiZvY1RmXX/w8EiOLwTlNupv1AyhG9cIarIH4i9cFHRzK
	N0cZBbQ8zJ87DDjlnyGT+lE2zll2LVBkph2aCW+849hWsWeFCkeqK3qat7TY4HtIEhH9CDqSthm
	pbgkwKB/kW3XpG/YtVQwBUCnLG4nNFrXJLx6HoJw24tMOjB+0Pq4vFUGg7AnfRVR6M7QnwxGYdI
	pGA2bXHRwuk+iP5LTbeV+mW3oO5N/LbPVwwJ3Ep9ZeqTiue1oMPZwhvBUAmeZ5VdSUAw7zXVAxE
	SFPoBdxG7dw05B0OqGQSfQt4eelJEziWoy/YPIDn6HdeclWhNcfbEywituOkm/D2EAhJjktTZ3G
	HJ8CZQ9TrsB3VhQUd6VxqB3JvxHDoaDdBtVtsjK0aFbGVdt6R+mMd5JlK5+N8BGQ=
X-Received: by 2002:a9d:7155:0:b0:7dc:e43f:4b31 with SMTP id 46e09a7af769-7dce43f602fmr2227418a34.12.1776881953020;
        Wed, 22 Apr 2026 11:19:13 -0700 (PDT)
X-Received: by 2002:a9d:7155:0:b0:7dc:e43f:4b31 with SMTP id 46e09a7af769-7dce43f602fmr2227400a34.12.1776881952535;
        Wed, 22 Apr 2026 11:19:12 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm14423408a34.19.2026.04.22.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:19:12 -0700 (PDT)
Message-ID: <39b283f4e3fe75a8b9ee324e5906c6635aafed40.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: Supports freeing newly created tree head
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Wed, 22 Apr 2026 11:19:10 -0700
In-Reply-To: <tencent_B50525C2BA56BB53331B9E5A1B444B281B08@qq.com>
References: <60605973b66496b04c6847ceb6fa46dfada6a628.camel@redhat.com>
	 <tencent_B50525C2BA56BB53331B9E5A1B444B281B08@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-18 at 17:37 +0800, Edward Adam Davis wrote:
> On Fri, 17 Apr 2026 15:03:17 -0700, Viacheslav Dubeyko wrote:
> > > hfs_bnode_put() does not support deallocating a newly created btree
> > > head node; therefore, regardless of whether hfsplus_bnode_find() succ=
eeds
> > > or fails, it cannot effectively reclaim the memory allocated for a ne=
wly
> > > created head node.
> > >=20
> > > When finding a head node, if the node is a newly created one, we can =
use
> > > hfs_bnode_free() to reclaim its memory.
> > >=20
> > > [1]
> > > BUG: memory leak
> > > unreferenced object 0xffff88811cabc840 (size 96):
> > >   backtrace (crc 3e2dadb7):
> > >     __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
> > >     hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
> > >     hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
> > >     hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548
> >=20
> > I need slightly more detailed and clear explanation how the issue has b=
een
> > happened and why we need to fix it in a such way. Currently, I don't ha=
ve the
> > complete picture how this happened. I am sure that you have the complet=
e
> > picture. :) Could you please share what you have in your mind? :) Don't=
 hide the
> > wisdom. ;)
>     fc_mount()
>      vfs_get_tree()
>       get_tree_bdev_flags()
>        hfsplus_fill_super()=20

We have multiple calls of hfsplus_btree_open(). Which particular b-tree do =
you
mean here?

>         hfsplus_btree_open()=20

I assume that you mean hfs_btree_open().

>          hfsplus_bnode_find(tree, HFSPLUS_TREE_HEAD)
>=20

We call hfs_bnode_find() here.

> =20
>           __hfs_bnode_create()
> 	   ...
> 	   node->this =3D cnid; // cnid is HFSPLUS_TREE_HEAD, it is 0
> 	   ...
> 	  ...
> 	  desc =3D (struct hfs_bnode_desc *)(kmap_local_page(node->page[0])
> 	  node->type =3D desc->type;
> 	  switch (node->type) {
> 	  ...
> 	  default:  // because node->type is 127, so run here
> 	  	goto node_error;

I think, maybe, we need to add some error message(s) when some error is
happened. What do you think?

> 	  ...
> 	  hfs_bnode_put()
> 	   ...
> 	   if (test_bit(HFS_BNODE_DELETED, &node->flags)) { /* head node not set=
 HFS_BNODE_DELETED flag
> 							     * so, the node will never be freed.
> 							     * Furthermore, even if the node were marked
> 							     * with the HFS_BNODE_DELETED flag, hfs_bmap_free()
> 							     * would still trigger BUG_ON(!node->this).
> 	   						     */

 node_error:
 	set_bit(HFS_BNODE_ERROR, &node->flags);
-	clear_bit(HFS_BNODE_NEW, &node->flags);
-	wake_up(&node->lock_wq);
+	if (num !=3D HFSPLUS_TREE_HEAD) {

Why do we need to distinguish is it HFSPLUS_TREE_HEAD or not? I don't see a=
ny
difference in node processing.

+		clear_bit(HFS_BNODE_NEW, &node->flags);

I think that we don't need to clear the HFS_BNODE_NEW. Because, we need to
analyze HFS_BNODE_ERROR in hfs_bnode_put().

+		wake_up(&node->lock_wq);

I assume that wake_up() should be called anyway. Why have you removed this =
call
for HFSPLUS_TREE_HEAD case?

+	}
 	hfs_bnode_put(node);
 	return ERR_PTR(-EIO);

@@ -694,6 +698,10 @@ void hfs_bnode_put(struct hfs_bnode *node)
 			hfs_bnode_free(node);
 			return;
 		}
+		if (test_bit(HFS_BNODE_NEW, &node->flags)) {

I suggest to analyze HFS_BNODE_ERROR here.

+			hfs_bnode_unhash(node);
+			hfs_bnode_free(node);
+		}

@@ -598,14 +598,18 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tr=
ee,
u32 num)
 		if (key_size >=3D entry_size || key_size & 1)
 			goto node_error;
 	}
-	clear_bit(HFS_BNODE_NEW, &node->flags);
-	wake_up(&node->lock_wq);
+	if (num !=3D HFSPLUS_TREE_HEAD) {
+		clear_bit(HFS_BNODE_NEW, &node->flags);
+		wake_up(&node->lock_wq);

What the point in this code? Why have you change the logic here?

+	}
 	return node;

And, could you please add these new details into the commit message?

Thanks,
Slava.

