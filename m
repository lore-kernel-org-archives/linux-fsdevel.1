Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC31A08AF;
	Tue,  7 Apr 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598180; cv=none; b=bNNbHdvsNbR3hU6LwbJaVHf7mYorW3KaH5zvkPEUHeO+JMe55lZUSPP74czKNUHmtBtboV/2wKhKp6sZ2tE55JkAFOxVaAG3e8lHGLigDmr8dgK1hTnFRKLSrEWhyavOS2ZkuXYFmMhzhQpFIXRzJtKcJ3Ecyitck0u02JwMskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598180; c=relaxed/simple;
	bh=sHx4OYVxnWzM+8EKgDC9Loyq12VSE5QiDtgvNuiSLi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViypfKt2J+4NQ+9VHEFpiEpnt+ixMflebKKYgCHbTqqSssxuk9PRpuK7HLuRWhkjf7Ny6IYygHZzdXbyOFGJM/ps/eogcMbLW1ErfF3PotorBGUy1uaP9eFY+qeKD23HAUf5JbbaR3mIQRaUKpSm8OIPrkcHA+dYP+rM12IUMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RWHt57fF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RWHt57fF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rZsS1twO57Ns/rtxDU1upMBwpsVW+eBDZf4yN8kfPIo=; b=RWHt57fFwoiQq8nqecJzRw9z4i
	OVTP+oy76lE7wly3ZVMBob14psfCIxGIPiQLej4COBv0b95TcnHHQ459o4lJLdDuGjwCvzoFhVHnT
	ZeE1kATAPHNTM/fUN1jGCp7DvFng05j41qQ1yrnNE2kuEkA6392b2eYo9EaYnBCCUSgl7Z19sHukR
	guX3r2zeG6d3J68qjSJj8XXoIBgDqiTordktXJQNCFqTgbZpnha2ozg/y9Ed2bhxJSezD91msddtw
	P2lG0Z+Xw/By1TBfy0PnRWmPyxj90OszgnM9gFqJaOXJ9jhoF9Kyr4ytDmKYeixZtTPmcd76/kAW3
	aQ5UrW2A==;
Received: from bl16-24-98.dsl.telepac.pt ([188.81.24.98] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wADqG-00DBst-Bs; Tue, 07 Apr 2026 23:20:12 +0200
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
In-Reply-To: <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
	(Joanne Koong's message of "Tue, 7 Apr 2026 10:43:47 -0700")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
Date: Tue, 07 Apr 2026 22:20:11 +0100
Message-ID: <87v7e24gdw.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

On Tue, Apr 07 2026, Joanne Koong wrote:

> On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> The implementation of lookup_handle+statx compound operation extends the
>> lookup operation so that a file handle is be passed into the kernel.  It
>> also needs to include an extra inarg, so that the parent directory file
>> handle can be sent to user-space.  This extra inarg is added as an exten=
sion
>> header to the request.
>>
>> By having a separate statx including in a compound operation allows the
>> attr to be dropped from the lookup_handle request, simplifying the
>> traditional FUSE lookup operation.
>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
>>  fs/fuse/fuse_i.h          |  23 ++-
>>  fs/fuse/inode.c           |  48 +++++--
>>  fs/fuse/readdir.c         |   2 +-
>>  include/uapi/linux/fuse.h |  23 ++-
>>  5 files changed, 355 insertions(+), 35 deletions(-)
>>
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 113583c4efb6..89e6176abe25 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>>
>>  enum fuse_opcode {
>> @@ -671,6 +676,8 @@ enum fuse_opcode {
>>          */
>>         FUSE_COMPOUND           =3D 54,
>>
>> +       FUSE_LOOKUP_HANDLE      =3D 55,
>> +
>>         /* CUSE specific operations */
>>         CUSE_INIT               =3D 4096,
>>
>> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>>         struct fuse_attr attr;
>>  };
>>
>> +struct fuse_entry2_out {
>> +       uint64_t        nodeid;
>> +       uint64_t        generation;
>> +       uint64_t        entry_valid;
>> +       uint32_t        entry_valid_nsec;
>> +       uint32_t        flags;
>> +       uint64_t        spare;
>> +};
>
> Hi Luis,
>
> Could you explain why we need a new struct fuse_entry2_out instead of
> reusing struct fuse_entry_out? From what i see, the only differences
> between them are that fuse_entry2_out drops attr_valid,
> attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
> the ~100 bytes per lookup? Would it be cleaner from an abi perspective
> to just reuse fuse_entry_out and ignore the attr fields if they're not
> necessary? The reason I'm asking is because I'm looking at how you're
> doing the lookup request reply to see if the fuse passthrough stuff
> for metadata/directory operations can be combined with it. But I'm not
> fully understanding why fuse_entry2_out is needed here.
>
> I'm also a bit confused by why the compound with statx is needed here,
> could you explain this part? I see the call to fuse_statx_to_attr()
> after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
> statx reply right back to a struct fuse_attr for inode setup, so if
> FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
> fuse_entry2_out, doesn't this solve the problem of needing to compound
> it with a statx or getattr request? I also noticed that the statx part
> uses FUSE_ROOT_ID as a workaround for the node id because the actual
> nodeid isn't known yet, this seems like another sign that the
> attributes stuff should just be part of the lookup response itself
> rather than a separate operation?

First of all, thanks a lot for looking into this patchset.  Much
appreciated!

The main reason for swapping the usage of attr by statx is that statx
includes some attributes that attr does not (e.g. btime).  And since I was
adding a new FUSE operation, it would be a good time for using statx
instead.  (Moreover, as new attributes may be added to statx in the
future, the benefits of using statx could eventually be even greater.)

This was suggested by Miklos here[0], before converting the whole thing to
use compound commands.  So, I was going to use fuse_statx in the _out args
for lookup_handle.  However, because the interface was getting a bit
complex with extra args (and ext headers!), Miklos ended up suggesting[1]
to remove attr completely from the lookup_handle operation, and use
compounds instead to have the full functionality.

Obviously, I may have misunderstood (or mis-implemented) the suggestions
that were done.  And hopefully the provided links to the discussion that
originated this approach will help.

Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, I
believe this is a more generic problem which will occur in other compound
commands as well.  If we want to create a new file system object and
perform some operation with it within the same compound, a similar
workaround will be required (or some sort of flag in the compound command
to signal this dependency).

I hope this helped to clarify a bit your questions.

[0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj8=
4xPPCMGQ@mail.gmail.com
[1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39D=
nVoVXMkA@mail.gmail.com

Cheers,
--=20
Lu=C3=ADs
