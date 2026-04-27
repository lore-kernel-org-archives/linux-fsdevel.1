Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624C39903A;
	Mon, 27 Apr 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281843; cv=none; b=nKhUw4oAtDhto8UBevwgoVi/WEtfI8A/V/MVML3s6QBSdXL6AsVoS1uD3MoCikce8LlMugGpaAfCkRUbpK26NUwtdqQ8lB+S1svDvDxVwtxoNtXJw2QqDkzeUiantEx7nXfaYrlOLr3mOBszJx6QpkKw+qoWi57Q23zAKbd+S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281843; c=relaxed/simple;
	bh=Xg5a9pWC87KrYBNN6ecFsOVZqHConA7Z7GBm/wg2OUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJlyEsdODDZMmxPKlcx9Dbw8/cozwAbRKesyhW/LGv9/8410uKHSEVNBrlPBhkRjew4J5NWh3D/5aRuYDvl6DTZrst9OfvfEzEaZCnemDGkGDvDosR7mRVCEypCNVjed6b4fx8gRF+91z8RJbSOPsPGJh0NY3IE1mr60QPfV0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LdXEgKc0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LdXEgKc0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FTS67ywjDq8WYWftNREE0XsuUEhxu/5CI/eyMX3sjIQ=; b=LdXEgKc04hljQnUc4tqNwvtdiw
	3ssxrYiPBRB9vABkm3ruFGNfyIJj2anT4ancqY2T9kosm9A7buDOl5ytq44y4ghH7jxbftcG/I6sP
	tMIZPKEGM5nSmBzM0IMxc1glHy4lBX/jipAS8btkcxEzzChZ2lUZrpKqlT13OfIhJ0E+wcfpr+CZ3
	tlNyWeVlj1xDtx4HMzqf6/uFBXxTLDg8aBQtCufsW9mTUyRmFtrOV34DHm/55xypl5S4pCNyVmmBj
	SBfv/FBjf8n5TVHHxq0g1W/COv0cpBfrmp1lzNN6F9o0J+aW8ztR8yY7NjfjILXYwkwB38bIKaIyR
	7EpAuGzA==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHIC3-002r7d-Lx; Mon, 27 Apr 2026 11:23:54 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: fix race between inode/dentry invalidation and
 readdir
In-Reply-To: <CAJnrk1bv4NK7MF4msYMAmbS=+vL=k8NLoLiNyM4QB+amccpOww@mail.gmail.com>
	(Joanne Koong's message of "Fri, 24 Apr 2026 12:35:11 -0700")
References: <20260424134935.16161-1-luis@igalia.com>
	<CAJnrk1bv4NK7MF4msYMAmbS=+vL=k8NLoLiNyM4QB+amccpOww@mail.gmail.com>
Date: Mon, 27 Apr 2026 10:23:50 +0100
Message-ID: <87mryokb89.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joanne!

On Fri, Apr 24 2026, Joanne Koong wrote:

> On Fri, Apr 24, 2026 at 6:53=E2=80=AFAM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> When there's a readdir in progress, doing a FUSE_NOTIFY_INVAL_{INODE,ENT=
RY}
>> on an inode or dentry may result in stale directory info being cached.  =
This
>> is because the invalidation does not reset the readdir cache.
>>
>> This patch fixes this issue by adding a call to fuse_rdc_reset() (modifi=
ed
>> to include the required locking) to these two operations, allowing the
>> readdir cache to be invalidated while it's being filled-in.
>
> Hi Luis,
>
> Just curious, are you hitting this issue in practice or is this mostly
> theoretical?
>
> afaict for fuse_notify_inval_entry(), it calls into
> fuse_reverse_inval_entry() -> fuse_dir_changed(parent), which calls
> inode_maybe_inc_iversion(). afaict, this actually increments i_version
> (since I_VERSION_QUERIED flag was set when the cache's iversion was
> initialized with inode_query_iversion() in fuse_readdir_cached()),
> which means the next readdir call will detect this version change and
> call fuse_rdc_reset() (in fuse_readdir_cached()). I'm not sure I see
> how this leads to stale directory info lingering in the cache after a
> concurrent fuse_notify_inval_entry()?
>
> For teh fuse_notify_inval_inode() case, which I'm assuming is the case
> you're running into where the directory is the inode being
> invalidated, I see the call to fuse_reverse_inval_inode() which calls
> invalidate_inode_pages2_range() if the offset was non-negative, which
> will invalidate the readdir cache's pages, which means on the next
> readdir call, will already call fuse_rdc_reset() when it detects the
> missing page in the cache (in fuse_readdir_cached()). So I'm not
> really seeing how this can happen either for the
> fuse_notify_inval_inode() case? Unless you are passing a negative
> offset, but as I understand it, passing a negative offset is used only
> if the server wants attributes invalidated [1], not any data.
>
> afaics, the onlyy stale directory info returned would be for the case
> for a concurrent readdir that has already passed the pos =3D=3D 0
> iversion/mtime check when the invalidation arrives, but that seems
> like a server synchronization issue, eg if the server wants uptodate
> data when doing a concurrent readdir and invalidation, they have to
> order that themselves. ANy fresh lookup after that though, I think
> wouldalways return fresh/non-stale data for the reasons mentioned
> above.
>
> Does this align with what you're seeing in the code or am I missing
> something here?

First of all, thanks a lot for looking into this and for doing such a
great description of the issue.

So, I did had a report regarding a possible race between a readdir and
invalidation when using keep_cache and cache_readdir.  But, unfortunately,
I don't have a lot of information regarding the actual issue, and it isn't
something reproducible.

Then, looking at the code (and, for full-disclosure, I've also looked at a
claude analysis that was handed over to me) I could see a race that I'm
trying to fix with this patch.  But I believe it's the race that you claim
above that it's a server synchronisation problem.  For example, with a
NOTIFY_INVAL_INODE operation, when fuse_reverse_inval_inode() is called
while fuse_add_dirent_to_cache() is being executed in parallel, the
iversion/mtime update could be missed.

It is possible to hit this small race by instrumenting the code, and I
could occasionally (and momentarily) see stale data while running readdir
in such instrumented testing environment.  Do you think that's something
inherent to the usage of the INVAL_INODE op, and this race will need to be
handled by user-space?

In fact, the report I got seemed to indicate that the issue was not going
away with a fresh lookup (though an 'echo 1 > /proc/sys/vm/drop_cache'
would fix it).  But maybe that's another indication that this is a problem
in the user-space server.

Cheers,
--=20
Lu=C3=ADs

>
>>
>> Assisted-by: Claude:claude-opus-4-5
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dir.c     |  5 +++--
>>  fs/fuse/fuse_i.h  | 13 +++++++++++++
>>  fs/fuse/inode.c   |  1 +
>>  fs/fuse/readdir.c |  6 +++---
>>  4 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 7ac6b232ef12..6e5851de3613 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1615,6 +1615,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
>>         if (!(flags & FUSE_EXPIRE_ONLY))
>>                 d_invalidate(entry);
>>         fuse_invalidate_entry_cache(entry);
>> +       fuse_rdc_reset(entry->d_inode);
>
> Hmm... I think this resets the child's readdir cache but it's the
> parent's readdir cache that would have to be invalidated, so would
> this have to be fuse_rdc_reset(parent)?
>
> Thanks,
> Joanne
>
> [1] https://libfuse.github.io/doxygen/fuse__lowlevel_8h.html#a9cb974af974=
5294ff446d11cba2422f1
>
>>
>>         if (child_nodeid !=3D 0) {
>>                 inode_lock(d_inode(entry));
>> @@ -1637,7 +1638,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
>>                 dont_mount(entry);
>>                 clear_nlink(d_inode(entry));
>>                 err =3D 0;
>> - badentry:
>> +badentry:
>>                 inode_unlock(d_inode(entry));
>>                 if (!err)
>>                         d_delete(entry);
