Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B603B5304;
	Wed,  8 Apr 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643764; cv=none; b=RQ6iiqpuDYGYQ8PJLUqVzfLIz/mYj7f3ZtS9aPUi9xl2DTepWKP9dm1zP+qm+ilJ9uhr+a9vMnlkkiYXlyUQsG2al06JCOxYmhqj56ObUVbaRoRvCFcIU1CEM5wXYIr9u0wcJt9T3cSMV4LzmDkAPVxOzZEk3zKT/81H3w4f67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643764; c=relaxed/simple;
	bh=QIEpJji1TfJqLOzPMAYDArLk96P5CTzdoQe2gwiuv9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aP9YXVYl22PNszBSUjlnxLcbQVyrME+EquQFhOcnD+pqG7XlKFalsQps3pQV0CzV0j+1SuwV6SlEGLnwx5x9+hfsJGaiGcB30L9In8Bq+JCMljZcuEKkz6K6yixC2RNepRu9SoPajTSL+869DYu8wxjvS1QEcYGtyeSk4PKdIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ETJ+h7XM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ETJ+h7XM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/K1cqBbmO2BrGXIkUCu69EK/41F59QC1xA5tpQ3GBQA=; b=ETJ+h7XMoyYJ7vohBep1EAfWzc
	ohE27euenn/SMZ5nFXRrOSK35QGHUA1o6XGIHUzHxVqNu/mXZGBKGEqhERDVfOWtd65/pRVNPiPj0
	rh7fRRfIbDmIUwjmFKBpG9wANUUM966RNvwgEEUaNAi6e2eLizZuLjd3pXoOsg4ushFnYfKml/T3b
	NKBDom8+z5oW/t6UIh3kl6dXSm3DC14ROsjIpcJzU/rLmmlixGFEAdUY7Y595OFeUvJgeBdIrasit
	cDNssihy3pN7gIyZfldMqCDAdehq3y3N/tGe7BXGRAdGrpy4hRSpnrPXwtC1t8NW0bSrl9gAgwC3F
	g083Xfdw==;
Received: from bl15-209-88.dsl.telepac.pt ([188.80.209.88] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAQ3C-00DQNG-8u; Wed, 08 Apr 2026 12:22:22 +0200
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
In-Reply-To: <CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com>
	(Joanne Koong's message of "Tue, 7 Apr 2026 16:24:50 -0700")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
	<87v7e24gdw.fsf@igalia.com>
	<CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
	<CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com>
Date: Wed, 08 Apr 2026 11:22:22 +0100
Message-ID: <87bjftlpk1.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07 2026, Joanne Koong wrote:

> On Tue, Apr 7, 2026 at 4:06=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>>
>> On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com> =
wrote:
>> >
>> > Hi Joanne,
>> >
>> > On Tue, Apr 07 2026, Joanne Koong wrote:
>> >
>> > > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.=
com> wrote:
>> > >>
>> > >> The implementation of lookup_handle+statx compound operation extend=
s the
>> > >> lookup operation so that a file handle is be passed into the kernel=
.  It
>> > >> also needs to include an extra inarg, so that the parent directory =
file
>> > >> handle can be sent to user-space.  This extra inarg is added as an =
extension
>> > >> header to the request.
>> > >>
>> > >> By having a separate statx including in a compound operation allows=
 the
>> > >> attr to be dropped from the lookup_handle request, simplifying the
>> > >> traditional FUSE lookup operation.
>> > >>
>> > >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> > >> ---
>> > >>  fs/fuse/dir.c             | 294 ++++++++++++++++++++++++++++++++++=
+---
>> > >>  fs/fuse/fuse_i.h          |  23 ++-
>> > >>  fs/fuse/inode.c           |  48 +++++--
>> > >>  fs/fuse/readdir.c         |   2 +-
>> > >>  include/uapi/linux/fuse.h |  23 ++-
>> > >>  5 files changed, 355 insertions(+), 35 deletions(-)
>> > >>
>> > >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> > >> index 113583c4efb6..89e6176abe25 100644
>> > >> --- a/include/uapi/linux/fuse.h
>> > >> +++ b/include/uapi/linux/fuse.h
>> > >>
>> > >>  enum fuse_opcode {
>> > >> @@ -671,6 +676,8 @@ enum fuse_opcode {
>> > >>          */
>> > >>         FUSE_COMPOUND           =3D 54,
>> > >>
>> > >> +       FUSE_LOOKUP_HANDLE      =3D 55,
>> > >> +
>> > >>         /* CUSE specific operations */
>> > >>         CUSE_INIT               =3D 4096,
>> > >>
>> > >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>> > >>         struct fuse_attr attr;
>> > >>  };
>> > >>
>> > >> +struct fuse_entry2_out {
>> > >> +       uint64_t        nodeid;
>> > >> +       uint64_t        generation;
>> > >> +       uint64_t        entry_valid;
>> > >> +       uint32_t        entry_valid_nsec;
>> > >> +       uint32_t        flags;
>> > >> +       uint64_t        spare;
>> > >> +};
>> > >
>> > > Hi Luis,
>> > >
>> > > Could you explain why we need a new struct fuse_entry2_out instead of
>> > > reusing struct fuse_entry_out? From what i see, the only differences
>> > > between them are that fuse_entry2_out drops attr_valid,
>> > > attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
>> > > the ~100 bytes per lookup? Would it be cleaner from an abi perspecti=
ve
>> > > to just reuse fuse_entry_out and ignore the attr fields if they're n=
ot
>> > > necessary? The reason I'm asking is because I'm looking at how you're
>> > > doing the lookup request reply to see if the fuse passthrough stuff
>> > > for metadata/directory operations can be combined with it. But I'm n=
ot
>> > > fully understanding why fuse_entry2_out is needed here.
>> > >
>> > > I'm also a bit confused by why the compound with statx is needed her=
e,
>> > > could you explain this part? I see the call to fuse_statx_to_attr()
>> > > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts t=
he
>> > > statx reply right back to a struct fuse_attr for inode setup, so if
>> > > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
>> > > fuse_entry2_out, doesn't this solve the problem of needing to compou=
nd
>> > > it with a statx or getattr request? I also noticed that the statx pa=
rt
>> > > uses FUSE_ROOT_ID as a workaround for the node id because the actual
>> > > nodeid isn't known yet, this seems like another sign that the
>> > > attributes stuff should just be part of the lookup response itself
>> > > rather than a separate operation?
>> >
>> > First of all, thanks a lot for looking into this patchset.  Much
>> > appreciated!
>> >
>> > The main reason for swapping the usage of attr by statx is that statx
>> > includes some attributes that attr does not (e.g. btime).  And since I=
 was
>> > adding a new FUSE operation, it would be a good time for using statx
>> > instead.  (Moreover, as new attributes may be added to statx in the
>> > future, the benefits of using statx could eventually be even greater.)
>> >
>> > This was suggested by Miklos here[0], before converting the whole thin=
g to
>> > use compound commands.  So, I was going to use fuse_statx in the _out =
args
>> > for lookup_handle.  However, because the interface was getting a bit
>> > complex with extra args (and ext headers!), Miklos ended up suggesting=
[1]
>> > to remove attr completely from the lookup_handle operation, and use
>> > compounds instead to have the full functionality.
>>
>> Thank you for the context and links, Luis!
>>
>> Using fuse_statx over fuse_getattr makes sense to me for the new
>> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
>> to be compounded. If we are adding a new struct (struct
>> fuse_entry2_out) to the abi, why is it not simpler to just make the
>> new struct something like:
>>
>>   struct fuse_entry_handle_out {
>
> Thinking more about how passthrough will use this... I'm thinking
> something like this would be ideal (though please correct me if I'm
> completely off track here, Amir):
>
>   struct fuse_entry_handle_out {
>       uint64_t    nodeid;
>       uint64_t    generation;
>       uint64_t    entry_valid;
>       uint64_t    attr_valid;
>       uint32_t    entry_valid_nsec;
>       uint32_t    attr_valid_nsec;
>       int32_t     backing_id;
>       uint32_t    flags;
>       struct fuse_statx statx;
>   };
>
> where if the inode is not passed through, the kernel uses the stax
> field for the attributes but if the inode is passed through and the
> server sets a bitmask specifying that attributes should be derived
> from the backing file, then the statx field will be ignored by the
> server and kernel).

If we end up deciding to revert back to not using compound commands I'll
have to take a closer look into this, as it's not clear what the above
means.  For example, when you say:

  "... if the inode is not passed through"

does this "inode" refer to the backing_id?  I guess this is some index to
backing ids being used by FUSE, not exactly an inode, but I'm not very
familiar with the code.

Cheers,
--=20
Lu=C3=ADs
