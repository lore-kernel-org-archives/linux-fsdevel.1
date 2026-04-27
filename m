Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B3194AE6;
	Mon, 27 Apr 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309595; cv=none; b=t0jdSXsXk/FmnVZrDmHFP1u14KxECLncc4ni+IvbKrXGqkAWO1rdcUq71ugXmXMaoAUsxyq5BqKKESLEEskYX1W2iMk3WzIj2QtU7uRHKrLWuCQy3HRPrR5x4/QvvoLVQ+D71SU02jC727ljYvWVHPRVsfbPmtQA0WHKHMSaqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309595; c=relaxed/simple;
	bh=01cUK7UA+m9F6zPUzY2XDWJ76JJL4AGjYttD+zNk2oY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2ELPHKfQmGDu8/iVXj8hZWMVZpG9EV4z9a4Lc2kf3RndCXQ5LrN1fuJv6kz9w/SOdhAS1X0mtlPbIhu+GcrRkj71aetdhCSf6LmE/txAE/l8zUISfwUk2YHgMSUdR3CsHH+t9XOT+eEk8zyX4nAzn2YseIwjt72bm0ayYRU5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RGP8B60o; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RGP8B60o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=V1BYaeG1CPEO9Nyv3+iMz7bAU/ipwECWMbDgGE7j0OI=; b=RGP8B60o7qwFqmccFm9pbLant2
	bgf+tgzFaCau0a8eIfaUzS2lJRTvx3R8lxYUMAdL+s1buqbADO2FAgOhy/LIDIIW3Fz3yhH6PoeVD
	f1fToPz3Fqjt7j0i9sf+XAWQd4exSyEWAHLtldeJQSbMOdoqXEhWPtZRjdHh0qLGkwNFTMm0jYEus
	v/XD0lERgRX4S4CL33K0qTzLtUfiWCxnmwY7H/WAOwP8sTAEoftivxKy6WcMKl/luJOKj7MHFEB+Y
	WOwsxEQ/3eTThRuljOn7p6ErPHHOo7BNLmbeZdblmAPnpJl/+swyF3iKlHJzXBgiqj4GjnUK0lcZO
	mmjZxf2w==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHPPf-0031De-MQ; Mon, 27 Apr 2026 19:06:26 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: fix race between inode/dentry invalidation and
 readdir
In-Reply-To: <CAJnrk1ZCyHtL6NEaSuww+RQvNNfAW8NkvRA=+=HXQwdG_4aE_Q@mail.gmail.com>
	(Joanne Koong's message of "Mon, 27 Apr 2026 13:48:19 +0100")
References: <20260424134935.16161-1-luis@igalia.com>
	<CAJnrk1bv4NK7MF4msYMAmbS=+vL=k8NLoLiNyM4QB+amccpOww@mail.gmail.com>
	<87mryokb89.fsf@igalia.com>
	<CAJnrk1ZCyHtL6NEaSuww+RQvNNfAW8NkvRA=+=HXQwdG_4aE_Q@mail.gmail.com>
Date: Mon, 27 Apr 2026 18:06:21 +0100
Message-ID: <87ik9cjpte.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27 2026, Joanne Koong wrote:

> On Mon, Apr 27, 2026 at 10:23=E2=80=AFAM Luis Henriques <luis@igalia.com>=
 wrote:
>>
>> Hi Joanne!
>>
>> On Fri, Apr 24 2026, Joanne Koong wrote:
>>
>> > On Fri, Apr 24, 2026 at 6:53=E2=80=AFAM Luis Henriques <luis@igalia.co=
m> wrote:
>> >>
>> >> When there's a readdir in progress, doing a FUSE_NOTIFY_INVAL_{INODE,=
ENTRY}
>> >> on an inode or dentry may result in stale directory info being cached=
.  This
>> >> is because the invalidation does not reset the readdir cache.
>> >>
>> >> This patch fixes this issue by adding a call to fuse_rdc_reset() (mod=
ified
>> >> to include the required locking) to these two operations, allowing the
>> >> readdir cache to be invalidated while it's being filled-in.
>> >
>> > Hi Luis,
>> >
>> > Just curious, are you hitting this issue in practice or is this mostly
>> > theoretical?
>> >
>> > afaict for fuse_notify_inval_entry(), it calls into
>> > fuse_reverse_inval_entry() -> fuse_dir_changed(parent), which calls
>> > inode_maybe_inc_iversion(). afaict, this actually increments i_version
>> > (since I_VERSION_QUERIED flag was set when the cache's iversion was
>> > initialized with inode_query_iversion() in fuse_readdir_cached()),
>> > which means the next readdir call will detect this version change and
>> > call fuse_rdc_reset() (in fuse_readdir_cached()). I'm not sure I see
>> > how this leads to stale directory info lingering in the cache after a
>> > concurrent fuse_notify_inval_entry()?
>> >
>> > For teh fuse_notify_inval_inode() case, which I'm assuming is the case
>> > you're running into where the directory is the inode being
>> > invalidated, I see the call to fuse_reverse_inval_inode() which calls
>> > invalidate_inode_pages2_range() if the offset was non-negative, which
>> > will invalidate the readdir cache's pages, which means on the next
>> > readdir call, will already call fuse_rdc_reset() when it detects the
>> > missing page in the cache (in fuse_readdir_cached()). So I'm not
>> > really seeing how this can happen either for the
>> > fuse_notify_inval_inode() case? Unless you are passing a negative
>> > offset, but as I understand it, passing a negative offset is used only
>> > if the server wants attributes invalidated [1], not any data.
>> >
>> > afaics, the onlyy stale directory info returned would be for the case
>> > for a concurrent readdir that has already passed the pos =3D=3D 0
>> > iversion/mtime check when the invalidation arrives, but that seems
>> > like a server synchronization issue, eg if the server wants uptodate
>> > data when doing a concurrent readdir and invalidation, they have to
>> > order that themselves. ANy fresh lookup after that though, I think
>> > wouldalways return fresh/non-stale data for the reasons mentioned
>> > above.
>> >
>> > Does this align with what you're seeing in the code or am I missing
>> > something here?
>
> Hi Luis,
>
>>
>> First of all, thanks a lot for looking into this and for doing such a
>> great description of the issue.
>>
>> So, I did had a report regarding a possible race between a readdir and
>> invalidation when using keep_cache and cache_readdir.  But, unfortunatel=
y,
>> I don't have a lot of information regarding the actual issue, and it isn=
't
>> something reproducible.
>>
>> Then, looking at the code (and, for full-disclosure, I've also looked at=
 a
>> claude analysis that was handed over to me) I could see a race that I'm
>> trying to fix with this patch.  But I believe it's the race that you cla=
im
>> above that it's a server synchronisation problem.  For example, with a
>> NOTIFY_INVAL_INODE operation, when fuse_reverse_inval_inode() is called
>> while fuse_add_dirent_to_cache() is being executed in parallel, the
>> iversion/mtime update could be missed.
>>
>> It is possible to hit this small race by instrumenting the code, and I
>> could occasionally (and momentarily) see stale data while running readdir
>> in such instrumented testing environment.  Do you think that's something
>> inherent to the usage of the INVAL_INODE op, and this race will need to =
be
>> handled by user-space?
>
> imo yes, that is not a bug in the kernel and userspace is responsible
> for synchronizing/coordinating that. I think the kernel is just
> responsible for ensuring that any subsequent readdirs are not stale,
> but afaict the existing code handles that.

Ack, thanks.

>> In fact, the report I got seemed to indicate that the issue was not going
>> away with a fresh lookup (though an 'echo 1 > /proc/sys/vm/drop_cache'
>> would fix it).  But maybe that's another indication that this is a probl=
em
>> in the user-space server.
>
> that seems weird to me, maybe there's something else at play here in
> addition to the concurrent race? Is there a repro for where the stale
> data survives a fresh lookup?

Unfortunately no, I do not have any reproducer.  And from looking at the
code I couldn't find anything else.  I'll have to look closer into the
user-space code doing the invalidation to try to understand what else
could be at play here.  And again, thank you for your feedback, Joanne.

Cheers,
--=20
Lu=C3=ADs
