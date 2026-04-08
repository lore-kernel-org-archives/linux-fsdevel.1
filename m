Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82E378D9B;
	Wed,  8 Apr 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643413; cv=none; b=p2QcU/9gQTwiexdNsU8PsH6Tfe42ywdiiCw6Xc0mlW+Fm6iM8UbBdE+rfsFhZp5+eOyTlCHo/3vAeuNupGoCXnEq0clwHT8EZ+ih26tF1xa/IVXVIUHcszTnE12qsNKjc+EPVAybnTuxcyaC9fhB6crMpcPSjW8ja9K/SVGZQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643413; c=relaxed/simple;
	bh=sebHj4Dd8lOyqemozbtGZy2Y9w4z4aKbuIPt9oJtUZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bs8NDnrXUwJfeQv0bYw+PyFd7ev3nzEjXsvAH0jpuGNJEc8Xr9YDAVpcb9kW3rUZ5aUAkvOoMV11RXL5cECegtLdZNCLqBRAqt7SLujJ9bYLXMeux30qWlIZek9w5SFLxplO9D+cebhkix/7IyfOi9o/uj2ir0nN6BzGoht/gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DZJeQzLl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DZJeQzLl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pgVHZUsujW92VZed1Bbdh2RXO43rdFthBlZHv8cDAfs=; b=DZJeQzLlvvYEUTgxgPr922jE1k
	eXyTEgaa8ohTCU3FihKChS20kG1QtHhmOJK9ecdymZf5g+uv72ecunb/zA0mtMxOoXSzdrPs/q4+U
	7sKCsLqxH5NAA4M/nLSBsF6lI2FkBjnC2HSHsgxm2vk62BVfiukjHR7Z27I7IUJJtmwBNv3/lZNvl
	ZoJSrFTkAgQdJQzwdVXNtnPQKvLbWd4rur+lzvHrN0z4HBxEWWNGAOTH/UmcHY5wv214mW+k4HHLx
	mhbyM9wpk1a8yTBZRwZpBo+fJl84AIxXkEO7c5vc1NSaGm/mmssMmLrpTBv3BtciAOM/UwXmIWDtI
	XcDLZRmQ==;
Received: from bl15-209-88.dsl.telepac.pt ([188.80.209.88] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAPxW-00DQC9-3e; Wed, 08 Apr 2026 12:16:30 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Bernd Schubert <bschubert@ddn.com>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Horst
 Birthelmer <hbirthelmer@ddn.com>,  Kevin Chen <kchen@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
In-Reply-To: <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
	(Joanne Koong's message of "Tue, 7 Apr 2026 16:06:13 -0700")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
	<87v7e24gdw.fsf@igalia.com>
	<CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
Date: Wed, 08 Apr 2026 11:16:19 +0100
Message-ID: <87fr55lpu4.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07 2026, Joanne Koong wrote:

> On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:
>>
>> Hi Joanne,
>>
>> On Tue, Apr 07 2026, Joanne Koong wrote:
>>
>> > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.co=
m> wrote:
>> >>
>> >> The implementation of lookup_handle+statx compound operation extends =
the
>> >> lookup operation so that a file handle is be passed into the kernel. =
 It
>> >> also needs to include an extra inarg, so that the parent directory fi=
le
>> >> handle can be sent to user-space.  This extra inarg is added as an ex=
tension
>> >> header to the request.
>> >>
>> >> By having a separate statx including in a compound operation allows t=
he
>> >> attr to be dropped from the lookup_handle request, simplifying the
>> >> traditional FUSE lookup operation.
>> >>
>> >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >> ---
>> >>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++-=
--
>> >>  fs/fuse/fuse_i.h          |  23 ++-
>> >>  fs/fuse/inode.c           |  48 +++++--
>> >>  fs/fuse/readdir.c         |   2 +-
>> >>  include/uapi/linux/fuse.h |  23 ++-
>> >>  5 files changed, 355 insertions(+), 35 deletions(-)
>> >>
>> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> >> index 113583c4efb6..89e6176abe25 100644
>> >> --- a/include/uapi/linux/fuse.h
>> >> +++ b/include/uapi/linux/fuse.h
>> >>
>> >>  enum fuse_opcode {
>> >> @@ -671,6 +676,8 @@ enum fuse_opcode {
>> >>          */
>> >>         FUSE_COMPOUND           =3D 54,
>> >>
>> >> +       FUSE_LOOKUP_HANDLE      =3D 55,
>> >> +
>> >>         /* CUSE specific operations */
>> >>         CUSE_INIT               =3D 4096,
>> >>
>> >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>> >>         struct fuse_attr attr;
>> >>  };
>> >>
>> >> +struct fuse_entry2_out {
>> >> +       uint64_t        nodeid;
>> >> +       uint64_t        generation;
>> >> +       uint64_t        entry_valid;
>> >> +       uint32_t        entry_valid_nsec;
>> >> +       uint32_t        flags;
>> >> +       uint64_t        spare;
>> >> +};
>> >
>> > Hi Luis,
>> >
>> > Could you explain why we need a new struct fuse_entry2_out instead of
>> > reusing struct fuse_entry_out? From what i see, the only differences
>> > between them are that fuse_entry2_out drops attr_valid,
>> > attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
>> > the ~100 bytes per lookup? Would it be cleaner from an abi perspective
>> > to just reuse fuse_entry_out and ignore the attr fields if they're not
>> > necessary? The reason I'm asking is because I'm looking at how you're
>> > doing the lookup request reply to see if the fuse passthrough stuff
>> > for metadata/directory operations can be combined with it. But I'm not
>> > fully understanding why fuse_entry2_out is needed here.
>> >
>> > I'm also a bit confused by why the compound with statx is needed here,
>> > could you explain this part? I see the call to fuse_statx_to_attr()
>> > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
>> > statx reply right back to a struct fuse_attr for inode setup, so if
>> > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
>> > fuse_entry2_out, doesn't this solve the problem of needing to compound
>> > it with a statx or getattr request? I also noticed that the statx part
>> > uses FUSE_ROOT_ID as a workaround for the node id because the actual
>> > nodeid isn't known yet, this seems like another sign that the
>> > attributes stuff should just be part of the lookup response itself
>> > rather than a separate operation?
>>
>> First of all, thanks a lot for looking into this patchset.  Much
>> appreciated!
>>
>> The main reason for swapping the usage of attr by statx is that statx
>> includes some attributes that attr does not (e.g. btime).  And since I w=
as
>> adding a new FUSE operation, it would be a good time for using statx
>> instead.  (Moreover, as new attributes may be added to statx in the
>> future, the benefits of using statx could eventually be even greater.)
>>
>> This was suggested by Miklos here[0], before converting the whole thing =
to
>> use compound commands.  So, I was going to use fuse_statx in the _out ar=
gs
>> for lookup_handle.  However, because the interface was getting a bit
>> complex with extra args (and ext headers!), Miklos ended up suggesting[1]
>> to remove attr completely from the lookup_handle operation, and use
>> compounds instead to have the full functionality.
>
> Thank you for the context and links, Luis!
>
> Using fuse_statx over fuse_getattr makes sense to me for the new
> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
> to be compounded. If we are adding a new struct (struct
> fuse_entry2_out) to the abi, why is it not simpler to just make the
> new struct something like:
>
>   struct fuse_entry_handle_out {
>       uint64_t    nodeid;
>       uint64_t    generation;
>       uint64_t    entry_valid;
>       uint64_t    attr_valid;
>       uint32_t    entry_valid_nsec;
>       uint32_t    attr_valid_nsec;
>       struct fuse_statx stat;
>   };
>
> and avoid the compound stuff altogether? Is it because that would make
> the struct fuse_entry_handle_out too big to be stack-allocated and
> would thus have to be heap allocated? But if I'm recalling correctly,
> the compound requests path requires heap allocations as well. Although
> at that point if we're gonna have to do the heap allocation, then we
> might as well just also embed the struct fuse_file_handle inside
> struct fuse_entry_handle_out?

I'm open to drop the usage of compounds for this, of course.  In fact,
during the v2 discussions I suggested here[0] the usage of a similar
struct fuse_entry_handle_out.  Using compound commands was a way to try to
simplify the interface.  But maybe at that point I was too quick at
jumping into the compound commands suggestion.  It may make sense to
reevaluate this decision if you think it simplifies things, specially for
passthrough.

[0] https://lore.kernel.org/all/87zf6nov6c.fsf@wotan.olymp

And I agree that the stack allocation is unlikely to be a good argument as
I can see that using compound commands can make these stack allocations
even worse, as we need to allocate more structs for more operations.

Miklos, do you have a opinion on this?

Cheers,
--=20
Lu=C3=ADs

> Thanks,
> Joanne
>
>>
>> Obviously, I may have misunderstood (or mis-implemented) the suggestions
>> that were done.  And hopefully the provided links to the discussion that
>> originated this approach will help.
>>
>> Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, I
>> believe this is a more generic problem which will occur in other compound
>> commands as well.  If we want to create a new file system object and
>> perform some operation with it within the same compound, a similar
>> workaround will be required (or some sort of flag in the compound command
>> to signal this dependency).
>>
>> I hope this helped to clarify a bit your questions.
>>
>> [0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sks=
Mj84xPPCMGQ@mail.gmail.com
>> [1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG=
39DnVoVXMkA@mail.gmail.com
>>
>> Cheers,
>> --
>> Lu=C3=ADs

