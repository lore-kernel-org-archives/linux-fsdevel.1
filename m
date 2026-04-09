Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034813BFE25;
	Thu,  9 Apr 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733023; cv=none; b=XSZkV/alBrUimZGh5Frj3Rakh82o091jbxEyUrVz9WQjCYcGUaiJ5n/ddVL1PVGaWMkJqNM3IbZSBmtMEtIGO7LBcz6/be/L6Vl554/nr2peatw4H5i7W4TSrtqBe+bv9d90KL8lfGZLj+46SzJ0is/tkmyANKOmEz+r0CfXeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733023; c=relaxed/simple;
	bh=3w0XcAfaAgMYpnbofUaykPjTuMzlLF7R1ICR8ORFEA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDY3yR82aLTm18C3QWRDliQqPnqEpawJ0zkCL+5nwovBmxGahK91yWarpI2jd2kxV2GFGNzIBE72Lj08xP9VQWQi6RV7CnUxi/SLCbn73evhtmAwX5chGjtyOS70Me3TVbcylUEJcT0nimdDzCeXFWXsRUaPcJKNs48VNsD/2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Odxw7z6+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Odxw7z6+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gY6lxrEedf9kICFMdC4m9Tl4+u/hf3WGm3hdZN8a7sM=; b=Odxw7z6+ju70oTdCR0C/jvSWye
	xpkh7OUsuCLhZGnNolSpdyP6y/TGUNMJeAkj6Bb2mcC+UnjB7NutfuV5YfVXcTrFCfbz95qvDL4zC
	lmtTR+rNDLSGH2naio1Ux4zD8r7skB9yFxf2DuyN5MDmwWnVYte+Ith0+pwqe4LiPOOk4B1YEO+0D
	VpKHqhfITUCvn0tVIJwBypKkQOTzQixHy9DVNUC+/qF5+wTMli4PnSEJVUvrNzAftU6cm0nF/cgDN
	52ncqU43b+YnIRgvDau1/wUCFjm0vc5E01h5qFrAs+aY6hH52Rt0C0P3TB+0SAHar4b4IZEALzjL6
	MYOhyg3w==;
Received: from bl15-209-88.dsl.telepac.pt ([188.80.209.88] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAnGv-00DuKM-TX; Thu, 09 Apr 2026 13:10:06 +0200
From: Luis Henriques <luis@igalia.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Amir Goldstein <amir73il@gmail.com>,  Bernd Schubert
 <bschubert@ddn.com>,  Bernd Schubert <bernd@bsbernd.com>,  "Darrick J.
 Wong" <djwong@kernel.org>,  Horst Birthelmer <hbirthelmer@ddn.com>,  Kevin
 Chen <kchen@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
In-Reply-To: <5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com> (Jingbo
	Xu's message of "Thu, 9 Apr 2026 10:27:35 +0800")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
	<87v7e24gdw.fsf@igalia.com>
	<CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
	<87fr55lpu4.fsf@igalia.com>
	<5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com>
Date: Thu, 09 Apr 2026 12:10:05 +0100
Message-ID: <87ika0z8xe.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09 2026, Jingbo Xu wrote:

> Hi Luis,
>
> On 4/8/26 6:16 PM, Luis Henriques wrote:
>> On Tue, Apr 07 2026, Joanne Koong wrote:
>>=20
>>> On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>> On Tue, Apr 07 2026, Joanne Koong wrote:
>>>>
>>>>> On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.c=
om> wrote:
>>>>>>
>>>>>> The implementation of lookup_handle+statx compound operation extends=
 the
>>>>>> lookup operation so that a file handle is be passed into the kernel.=
  It
>>>>>> also needs to include an extra inarg, so that the parent directory f=
ile
>>>>>> handle can be sent to user-space.  This extra inarg is added as an e=
xtension
>>>>>> header to the request.
>>>>>>
>>>>>> By having a separate statx including in a compound operation allows =
the
>>>>>> attr to be dropped from the lookup_handle request, simplifying the
>>>>>> traditional FUSE lookup operation.
>>>>>>
>>>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>>>> ---
>>>>>>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++=
---
>>>>>>  fs/fuse/fuse_i.h          |  23 ++-
>>>>>>  fs/fuse/inode.c           |  48 +++++--
>>>>>>  fs/fuse/readdir.c         |   2 +-
>>>>>>  include/uapi/linux/fuse.h |  23 ++-
>>>>>>  5 files changed, 355 insertions(+), 35 deletions(-)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>>>>> index 113583c4efb6..89e6176abe25 100644
>>>>>> --- a/include/uapi/linux/fuse.h
>>>>>> +++ b/include/uapi/linux/fuse.h
>>>>>>
>>>>>>  enum fuse_opcode {
>>>>>> @@ -671,6 +676,8 @@ enum fuse_opcode {
>>>>>>          */
>>>>>>         FUSE_COMPOUND           =3D 54,
>>>>>>
>>>>>> +       FUSE_LOOKUP_HANDLE      =3D 55,
>>>>>> +
>>>>>>         /* CUSE specific operations */
>>>>>>         CUSE_INIT               =3D 4096,
>>>>>>
>>>>>> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>>>>>>         struct fuse_attr attr;
>>>>>>  };
>>>>>>
>>>>>> +struct fuse_entry2_out {
>>>>>> +       uint64_t        nodeid;
>>>>>> +       uint64_t        generation;
>>>>>> +       uint64_t        entry_valid;
>>>>>> +       uint32_t        entry_valid_nsec;
>>>>>> +       uint32_t        flags;
>>>>>> +       uint64_t        spare;
>>>>>> +};
>>>>>
>>>>> Hi Luis,
>>>>>
>>>>> Could you explain why we need a new struct fuse_entry2_out instead of
>>>>> reusing struct fuse_entry_out? From what i see, the only differences
>>>>> between them are that fuse_entry2_out drops attr_valid,
>>>>> attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
>>>>> the ~100 bytes per lookup? Would it be cleaner from an abi perspective
>>>>> to just reuse fuse_entry_out and ignore the attr fields if they're not
>>>>> necessary? The reason I'm asking is because I'm looking at how you're
>>>>> doing the lookup request reply to see if the fuse passthrough stuff
>>>>> for metadata/directory operations can be combined with it. But I'm not
>>>>> fully understanding why fuse_entry2_out is needed here.
>>>>>
>>>>> I'm also a bit confused by why the compound with statx is needed here,
>>>>> could you explain this part? I see the call to fuse_statx_to_attr()
>>>>> after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
>>>>> statx reply right back to a struct fuse_attr for inode setup, so if
>>>>> FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
>>>>> fuse_entry2_out, doesn't this solve the problem of needing to compound
>>>>> it with a statx or getattr request? I also noticed that the statx part
>>>>> uses FUSE_ROOT_ID as a workaround for the node id because the actual
>>>>> nodeid isn't known yet, this seems like another sign that the
>>>>> attributes stuff should just be part of the lookup response itself
>>>>> rather than a separate operation?
>>>>
>>>> First of all, thanks a lot for looking into this patchset.  Much
>>>> appreciated!
>>>>
>>>> The main reason for swapping the usage of attr by statx is that statx
>>>> includes some attributes that attr does not (e.g. btime).  And since I=
 was
>>>> adding a new FUSE operation, it would be a good time for using statx
>>>> instead.  (Moreover, as new attributes may be added to statx in the
>>>> future, the benefits of using statx could eventually be even greater.)
>>>>
>>>> This was suggested by Miklos here[0], before converting the whole thin=
g to
>>>> use compound commands.  So, I was going to use fuse_statx in the _out =
args
>>>> for lookup_handle.  However, because the interface was getting a bit
>>>> complex with extra args (and ext headers!), Miklos ended up suggesting=
[1]
>>>> to remove attr completely from the lookup_handle operation, and use
>>>> compounds instead to have the full functionality.
>>>
>>> Thank you for the context and links, Luis!
>>>
>>> Using fuse_statx over fuse_getattr makes sense to me for the new
>>> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
>>> to be compounded. If we are adding a new struct (struct
>>> fuse_entry2_out) to the abi, why is it not simpler to just make the
>>> new struct something like:
>>>
>>>   struct fuse_entry_handle_out {
>>>       uint64_t    nodeid;
>>>       uint64_t    generation;
>>>       uint64_t    entry_valid;
>>>       uint64_t    attr_valid;
>>>       uint32_t    entry_valid_nsec;
>>>       uint32_t    attr_valid_nsec;
>>>       struct fuse_statx stat;
>>>   };
>>>
>>> and avoid the compound stuff altogether? Is it because that would make
>>> the struct fuse_entry_handle_out too big to be stack-allocated and
>>> would thus have to be heap allocated? But if I'm recalling correctly,
>>> the compound requests path requires heap allocations as well. Although
>>> at that point if we're gonna have to do the heap allocation, then we
>>> might as well just also embed the struct fuse_file_handle inside
>>> struct fuse_entry_handle_out?
>>=20
>> I'm open to drop the usage of compounds for this, of course.  In fact,
>> during the v2 discussions I suggested here[0] the usage of a similar
>> struct fuse_entry_handle_out.  Using compound commands was a way to try =
to
>> simplify the interface.  But maybe at that point I was too quick at
>> jumping into the compound commands suggestion.  It may make sense to
>> reevaluate this decision if you think it simplifies things, specially for
>> passthrough.
>>=20
>> [0] https://lore.kernel.org/all/87zf6nov6c.fsf@wotan.olymp
>>=20
>
> Many thanks for your work on this.
>
> Just FYI We are also interested in the kernel-maintained filehandle,
> which can dramatically help reduce the memory footprint on the FUSE
> server side.

Awesome!

> It just seems that the overall design is still not clear right now.  I'd
> like to and would be happy if I could help any.

Thanks you, Jingbo.  I guess that for now we need to revalidate the usage
of compounds or going back to my previous (v2) approach.  If we end up
deciding to drop compound commands, I can try to get a new version of the
patchset before LSFMM so that we can eventually discuss more details
there.

Cheers,
--=20
Lu=C3=ADs
