Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8E360EC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405902; cv=none; b=UHkysE3WWGJmUCdJmy7Ch16giuShPGseo3KPrMbfzk526/aZ9Ip4n5SZukX6VFNRGatASoYHdPt9hPhyb38WaQ9olaocuuHt+upmDk0SGQS4qzusC/w6wtUSQy+uco3D7haJULQaoFu1/wT1Xoaz6RIqDTFgL2zsLhDuWVFRi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405902; c=relaxed/simple;
	bh=FyOhAlIR/gvNqtRsDhvA/OHQLYO5pLvIy5zJ4aTGP4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDJBd+VC7Qw8LBVDX0Z4nlrOAgTqhoVS8k4+KTJq64zr/l2p0ItUY4yawL9Btk/9knE+JGTEZbsdjSWq+F6cz72cRc2rUSfAcuZ2ezUSsCegLNB620bSWiGu5Q27Hy8UZ/zx+pKcox985vwf7EOHEYtzzYgFovmUQo34Uzgpk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FIUP1RsJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAT01khk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FIUP1RsJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAT01khk"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20B761400143;
	Wed,  2 Sep 2026 23:24:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 23:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1788405898; x=1788492298; bh=CWm+I046SO
	AsahOYHlEKtHciW018L9gtfiIyhpHz9EE=; b=FIUP1RsJLbxqXY0qTUSsgnVGE0
	4m7oHXm48nDS4kB6ihO83kz9Z+oA2KtFU9KHNK7LNHsjFNkfS58/4Od4dpc32ou/
	Se80L1SZQt4JcoSaeMzyp4jhQv71EnwsABokDbVImbqHkHicfNU6hQL3h5ad1fZq
	v+7U2OjADwSRLcuQmulM+2XF36yzQeEc2X20k+aOQ23YVb5zVZKYQBK6KW+1v975
	8s27NTbh/90Foa04/6uZ4v19S/FrH+TkiuHt75hShhqVG0pWwRaqI85ITuUxdDAt
	phqNoHxBDyfmkAe2p3y4B7/c53pEbNMXkSPrEmDgY1DJUxwo4LItuB24P36Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788405898; x=1788492298; bh=CWm+I046SOAsahOYHlEKtHciW018
	L9gtfiIyhpHz9EE=; b=NAT01khkbRLQ34rdZyM07OfjrK0sv1WQc2Y+RORKxGRY
	R2KWc66DgDD79wwmkIHAGq5lRQV5s3MTAXPkCzONLCsc/5Jy6wX50w70yeCSorJs
	1KoZdQNcnC9bJECNuH4mP42oFQUSJqRmbjGPviUrh3poKsHYPx0z8XPHs9g3t8cC
	+fx5pMthlH0edORanEKnbN4ApvtPTF5QUsqMkt5HD3hgWvS3Aqs35TuKdmxQ5I+Z
	yKe5jCHh0bvGOX+Rdn/OhqPzgOcFrazjhDw8uibGHfinOTsFhb4hQBhws51ZMM9o
	O32eTO0dT5bGNEm/Dmtub8bzKkyOYdpBhjLxVVCEuA==
X-ME-Sender: <xms:ieiYaguBMdLKjw6jqUMNC9Ppw6XG9lYfUdVVhI4LGovCkHXMfTZELQ>
    <xme:ieiYangzdctsNAn6JwbaYNbkXe7F8JEi_tFYM6VnKuhgkun3NcwZVBBZuAl7qibzG
    kpSVBxsJPY5ny6_XbxCDqNifW3Fw7zZZEyG6CRV23QoJ7dpj48>
X-ME-Received: <xmr:ieiYaroVn-NDzEChv-l3sEQmbdYxSmz8TGDlOR7JK9YKVLHPCLlw8EFB94sakk4vWnW9K_y4h6998C57fJZ90K_hKrn2-f0>
X-ME-Proxy-Cause: dmFkZTFuAayE0kBG+OxoAdyfiWrFhX9rNr2V4EpoJFRFNnZXUoHtjrDKEZsj2cPRKrZgBi
    qdsoAXGrx6jF441coD6pOC+IqK2KpZUVCi0CQI1YBzq2vbEp8k2px4qlkhdfEjNDFBs48C
    7pMdWBTVeXwG6TFcCMhNpbHBb17dUOx8JctmKXO5jpCMVlM+Xa4p7cdf8ObrTj7VO6qROr
    61OCqDBmJ6W1Nb5we5ENrV77f5ftYeMX5jLEYq3Kue4OnrwF40yKD1Nzaa02grinq3BnFX
    8P5E/GDpVkqwsGVPLeDgoZzRe0hjOV1AE9ZZOxjwr5tP64Klufy2ZjYwDi/P14w3hTc+pS
    ULBhRdoivf9MOkARu3xgqb10oMy3BybfjdjHKi47oShqGx5n3l2m3nSLhjXgzY5Aq4z9f2
    Q/KCImvPn/cZLuPV4qcQn5/SWr5ACBUbjEDGoZeily+YzhpnGxQYy6+GwmBEZDKwCIgycP
    753kr04LSykoPS2Ryu2SAJhBbKE4vmsHGcGHZcpJpWtPLTAj9BW6M4jzcSr4DYqdE+olvf
    knwj/GQckWNDTywiM7peS4mwFoa13IPAPlbSn3aEJQeugjNfGqL9vbNag+sFDuaOB2tdsu
    L41oVoJJS+tP+EwiMYqZTKET+OrbuCNYL+0btFgbjFxQ5b9vN9NIEKVIM38w
X-ME-Proxy: <xmx:ieiYaktXIrovJH0xrBQWsrsvCzg6Xubd0ccI73rWqbgaw3MYWUjxsA>
    <xmx:ieiYauZKvTFPEsZpo_EETAa7VyNbMPoSTa5YiRaFbjzq06eNNOJPhw>
    <xmx:ieiYaral1DO9cB8Sfwq_kEuZYOaqfzL56H0qghudH0fN0gL7HU76pg>
    <xmx:ieiYavmgct6KB2HHNg88mxBY1SOgQe4U1D-a2WFjjFdQ_1eKWGG5wA>
    <xmx:iuiYalSyOSq7iP23rcal6-hJp9p5cu0lx44WRCljx0xAHYyDLRJXBWgr>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:24:55 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 0/6] VFS: prepare for changes to directory locking
Date: Thu,  3 Sep 2026 13:01:30 +1000
Message-ID: <20260903032431.142777-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
 As you know I am working on changes to locking for directory operations
such as lookup/create/remove/rename.  The ultimate goal is for the VFS
to lock the dentry, not the parent directory, and to push the i_rwsem
parent locking down into the filesystems where it can be kept, removed,
or adjusted as best fits each filesystem.

The next step is to change the order of locking for d_alloc_parallel() -
which allocates a locked (in-lookup) dentry or waits for an existing
dentry to be unlocked.  Currently d_alloc_parallel() is ordered below
i_rwsem on parent, so you cannot wait on i_rwsem while holding a locked
(in-lookup) dentry.

To push i_rwsem into filesystems I need to push i_rwsem below d_alloc_parallel(),
so code can wait for i_rwsem while holding an in-lookup dentry, but won't be
able to wait in d_alloc_parallel() while holding i_rwsem.

There are two broad changes that are needed before that order can be
swapped.  This series sets the direction.  Subsequent patches which I
hope can also land this cycle spread those changes throughtout
filesystems.

The two changes are:
1 - don't call d_alloc_parallel() while holding i_rwsem.
   This involves introducing d_alloc_trylock() and changing
   some places to drop i_rwsem before taking d_alloc_parallel()
   for this to work they will need to know if the lock is shared
   or exclusive so LOOKUP_SHARED is added.

2 - don't d_drop() a dentry while it being worked on.  This might
   not be entirely needed yet, but it will be needed soon and doing it
   now is a convenient time, and it helps make the end result clearer.
   Calling d_drop() effectively unlocks an in-lookup denty.
   It is OK for a filesystem to do this *after* an operation has
   completed, whether in success or failure.  Doing it before completion
   will allow another dentry to be allocated maybe too early.

   Enhancing d_splice_alias() to handle hashed dentries is key to
   removing the need to d_drop() in filesystems.  Though not strictly
   necessary, this allows d_add() to be removed as there will be nothing
   that d_add() does which cannot be done with d_splice_alias()

This set of 6 patches makes core-VFS changes. After this I have
 - 7 nfs patches
 - 6 afs patches
 - 4 smb/client patches
 - 3 cephfs patches
 - 2 fuse patches
 - one each for shmem, code, configfs, hostfs, procfs, ovl
and a patch to d_add_ci() which affects xfs and ntfs.

Once all of those have landed I have 4 patches to remove deprecated interfaces.
All of these can be found at
   https://github.com/neilbrown/linux/commits/pdirops


If all goes to plan, then in the next cycle a few patches will invert the
lock order and remove LOOKUP_SHARED.  Then we can get on to the really
fun stuff! (branch pdirops-next)

Thanks,
NeilBrown

Patches for this series

 [PATCH v3 1/6] VFS: fix various typos in documentation for
 [PATCH v3 2/6] VFS: enhance d_splice_alias() to handle hashed
 [PATCH v3 3/6] VFS: introduce d_alloc_trylock()
 [PATCH v3 4/6] VFS: add d_duplicate()
 [PATCH v3 5/6] VFS: Add LOOKUP_SHARED flag.
 [PATCH v3 6/6] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.

Subject-line for patches I will post after these are in vfs.all (subject
to change);

 nfs: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
 nfs: use d_splice_alias() in nfs_link()
 nfs: don't d_drop() before d_splice_alias()
 nfs: don't d_drop() before d_splice_alias() in atomic_create.
 nfs: Use d_alloc_trylock() in nfs_prime_dcache()
 nfs: use d_alloc_trylock() in silly-rename
 nfs: use d_duplicate()

 afs: use d_time instead of d_fsdata
 afs: don't unhash/rehash dentries during unlink/rename
 afs: use d_splice_alias() in afs_vnode_new_inode()
 afs: use d_alloc_trylock in afs_sillyrename()
 afs: lookup_atsys to drop and reclaim lock.
 afs: use d_duplicate()

 smb/client: use d_time to store a timestamp in dentry, not d_fsdata
 smb/client: don't unhash and rehash to prevent new opens.
 smb/client: use d_alloc_trylock in cifs_silly_fullpath()
 smb/client: Use d_alloc_trylock() in cifs_prime_dcache()

 cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME handling in ceph_fill_trace()
 cephfs: Use d_alloc_trylock() in ceph_readdir_prepopulate()
 cephfs: Don't d_drop() before d_splice_alias()
 cephfs: stop using d_add()

 fuse: don't d_drop() before d_splice_alias()
 fuse: Use d_alloc_trylock() in fuse_direntplus_link()

 VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
 shmem: use d_duplicate()
 coda: don't d_drop() early.
 configfs: remove d_add() calls before configfs_attach_group()
 hostfs: don't d_drop() before d_splice_alias() in hostfs_mkdir()
 procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
 ovl: stop using lookup_one() in ovl_iterate().


 Remove references to d_add() in documentation and comments.
 VFS: remove d_add()
 VFS: remove d_rehash()
 VFS: remove lookup_one() and lookup_noperm()
