Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AC3E0223
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542072; cv=pass; b=pDKrRKNMlEGK6NBrQvkLutuW8btwib1O/zcYwC5+DGMrpOmn9GycdpmZuT61lf6j5cifUc83JS6YUXee2Jqh0Fnfe/gJuEywltvxeQwfulj52PDIZes2h3yuayjmDeQGUktlSKk6WmGlH+g1sRgGmcKtHaMfT/OLH/K8ZmZbG7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542072; c=relaxed/simple;
	bh=0rQxBYeUI9kccjQsg7LlbwcyM5KH4xYI/FlafZxUfTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv1nDqN9YvpeJFNOymMao5nA/iBA+/XnkV1fYTigei9zDShQ18634zBBQPcV4K0GnBvDX8qZxWSksjYPynnIP9HCdVbkzB2RsMZwuaA+qdgBFq3+v8ecFO2tfaDd8g+EzG/TJlBlgPmCPK7w5rsdpoiNGeyaga8pldyDdeYFh8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENQQ6fSS; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENQQ6fSS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1671ec8692so621583566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 03:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784542061; cv=none;
        d=google.com; s=arc-20260327;
        b=BBbCZf26m2rxWI5Lak+Trr03e1FH/7znAt9f1OpB0IGbjggyzs1nrNX3DNy2c0E+g6
         A6RC1Bvc7gx1Rwucwmu59jnAWJHnO+sv62yKmhkkquwyw/Rj0lZL/DPGUGB6psrzbgln
         GBTeRm5szSkhm5cMe+JCUwBxOX8dc47OIFpDNfo0V/dKSe5E43MDWfp0n555NgkfKXOF
         SfwBhN07OMGLB0VwTXrJEg5csSjYJnTh16iCecLriwFOpZLBHA2cJsPGfz1mlbtDTDCC
         AW3C+818Rixf4+2mkLwMR2W9JajHpYs4bllrnaqOrpP9sGrprEaOgsqFXrn+Ec8RCd4L
         96IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCCq1AIeKXMGUk+k9l/Opmj013LJUPQC31Mm1vW63VU=;
        fh=i3raaIym1HPZXaHSaa61q/AnqURqrzl+eyMx8dIripw=;
        b=atk3XHeVYe32LH1Ei9O/sZ0x/2mUdO2ojRw0w50lmK2pqQhwSAMRHuKBs1w7cDLSlv
         Zo6Pi+jCaqvvL0VNvM45zQet+YXecoA752ThSbpe9LSVZ4IYiPvg1chT+C+tmN+FqCPc
         E1qpQCvIZCR9CmoT9YCw4kQPczV3UKrydZRlExMbpHWHOapcjMkF+V/gsbZkN9jR8d3U
         eYyBNjAefJFLvxLhvAjHSTJV6/KyA/QPNu8b8ZXn9EeVYep1ZbCjJPWDa5a84VoWbx3+
         LgNX3ub1iMHHnv3hhFfX2wG5DbK64mRSGK5a6LoIIlhZlwF7MzdkyS75iD2J0gXuFYqv
         r2oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784542061; x=1785146861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCCq1AIeKXMGUk+k9l/Opmj013LJUPQC31Mm1vW63VU=;
        b=ENQQ6fSSLVfcUYDy3ip1f4SSQUvz8U8E61dUWzjHQgucda3jPA2Y8U/nZiyn0xnE7f
         tY3a7J4UCv/G43hNNsd/717ArtTfUD82unVWh98UPdYlikdZkRrzGkeDGRZ1ESU5LA54
         MXi2HDdh2mRoFu7p+UC85KdsF2ykfriHUcNHFM9zCIaKAePy0bSr9F3hStnTNzy3gG4C
         SPiQ8eCBdQAB3ndslMuYbKjv3yVcea/ACdz6Mn7y7h2q3XMNRXQZ/Gx/oeSLlL2yS67N
         /ZNVrRHnz/HqEH8xsliVmNKOfUIU8ZKr58s7fmPv04zM+fLMfYSmYeXs8kpDxSxr5awB
         j0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542061; x=1785146861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCCq1AIeKXMGUk+k9l/Opmj013LJUPQC31Mm1vW63VU=;
        b=CNTqNHuv86Tvvaa71vFEC2fhYEprlrJGMsxrTgtsQuo+sz9BMb96FnKjTLORr6VlAC
         44uv4Vz5oACP4PVWbN0PmGESQ6sF/aAvZcXlc1EEI0HtB02ZrwXKWpvURytc4+8RuCVB
         zTv+tJZlcUw8cYWW1x5/PSww0toYDdn0sTL07y+YajO00z4JaNqavJpzIDflmCt+YE17
         a6xJgkz2l9wKwHdXxsvEyEmWk5uBZQYNFucdy6MwRzfHomJnaWE6ARKWa28r3ljESAvO
         tVDv+AlVJLgcs1wpwfiWH2rihiIRb7N7s4iiAuWve84OSC+8nlk2uPUC7tOyxfqgJIVD
         AtAA==
X-Forwarded-Encrypted: i=1; AHgh+RonSPrMi+WhGpjKRE3FW7EHnSucxUEnETu0+eZ4lNsop8ijs35+eGZiFwbg56IcHDwlmBaUSJ+t8hP1qLVC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7utGA7Rd+SZPXWeSnMUlXXQu933cf3hoHi+TFAEfiChtiHLo
	QpEAlFzLYtc/ythBcVQuS80VjihEM18iQM07Pz5ckfaSISMiaki8OftmFmO2lKVSmFinwuxA/Gw
	GsJ7OA8f5R282LC9iICDLrHml0cV70GQ=
X-Gm-Gg: AfdE7cnma0A6RGD0U3/9xRIkEOkl89AGyDMwj9UOYcEI4c5bl0RsSX+gRV1rOP3EoHE
	2Ib2AQ48da1tdm+5HUM0n0UOEdRDH6TDU0A9cgePhVfGxOEOAtFGssFWIyCckssL39v3R72PWaj
	ZaivgLfeNTCWvZtNNWhnQea4JcKe+ODOOc8WumEI0JKz4fM446uUqTYRGvI9H3WfZBFlE6DhWlz
	lLdMagEpB/qISmHW8dFRcwDeEkZCOD0uiNPuZ7+5YNGsxoqv+gO5PytfQKGTnHBDkwyJGNUmg==
X-Received: by 2002:a05:6938:a087:10b0:c16:7969:12be with SMTP id
 a640c23a62f3a-c16b47c1e4emr338791966b.31.1784542060903; Mon, 20 Jul 2026
 03:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
In-Reply-To: <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jul 2026 12:07:29 +0200
X-Gm-Features: AUfX_mz15n8tVrhQrtGTVlRLA7H7ya2xjAmCYkRT34S0zyePGJ2_WjcXc9IUx7k
Message-ID: <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:44=E2=80=AFAM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <john@groves.net>
>
> This has been quite a gauntlet so far. Some requests were made but eventu=
ally
> ruled out (e.g. using BPF for fault handling).

I'm sorry John, but this patch set is not what I was hoping to see.
I don't know if we are miscommunicating or if it is something else.
I will try to do my best to explain again.

I say miscommunication when looking at your comment in reply to [1]:
"First, a scope check. This patch touches only the daxdev registration -
GET_FMAP, struct fuse_famfs_fmap_header, and the simple/interleave
extent structs in include/uapi/linux/fuse.h are untouched. I'm reading
that as tacit agreement to GET_FMAP and its ABI. Can you confirm? If so
the large piece is settled and this is really just about how a daxdev
gets registered."

This was a wrong assumption on your part, it was NOT confirmed and
I even responded to it with a mini tantrum.

I feel that you may have not gotten Miklos' second patch [2] at all, becaus=
e
you have not responded to it.
Maybe because it was sent only to your work email?

>
> Concrete requests (demands?) from the fuse community included the followi=
ng:
> - Pass daxdevs into the kernel via an ioctl rather than a new fuse
>   message/response

Look at this patch by Miklos:
[1] https://lore.kernel.org/fuse-devel/20260529134302.1989958-1-mszeredi@re=
dhat.com/

Look more closely at the diffstat:
 7 files changed, 123 insertions(+), 294 deletions(-)

It's not about this ioctl, it's about infrastructure reuse.
It's about the fact that there is NOTHING special about dax_devlist;
and no reason not to manage it via backing_files_map.

The reason you stated was that you want userspace to determine the
daxdev_index/backing_id - fine, no problem - this is why I asked that
you pass it the desired backing_id in the ioctl.
In fact I think that all fuse backing_ids would be better assigned by user =
space
so the extension of padding =3D> backing_id is not unique to famfs.

And the best part is that this request requires no changes to your userspac=
e.
You already bite the bullet and maintain the new/old uapi but changing the
kernel implementation does not require this burden from you, so to be hones=
t
I really don't understand why you did not follow Miklos' suggestion.

> - Lose the famfs interleaved extent format. I have complied with this req=
uest.
>   It makes some things worse, but we'll discuss that later.
>

I am really not aware of a request to lose the interleaved extent format.
How can this patch [2] from Miklos which reimplements this format as a gene=
ric
uapi be mistaken for a request to lose this format?

> There has also been a desire from the fuse community for famfs to use an
> experimental implementation of virtual backing-devs from Darrick. I'm lea=
ving
> this out as a potential future optimization - although Darrick has announ=
ced
> that he (and $employer) intend to abandon that work, so it's not clear wh=
ether
> that will become viable.

Forgive me John, but I am having a hard time following the logic of
this statement.
How are Darrick's future plans about fuse iomap even remotely related?

In this patch Miklos has ALREADY IMPLEMENTED
"striped "virtual" backing devices (idea from Darrick)"
[2] https://lore.kernel.org/linux-fsdevel/20260601152327.2069787-1-mszeredi=
@redhat.com/

An idea does not die when employers change priorities.

The diffstat is also impressive:
 6 files changed, 219 insertions(+), 300 deletions(-)

Especially when considering the fact that the insertions are generic code
that could be useful to fuse passthrough regardless of famfs.

Let me recap the former review requests as I understand them:

1. Use ioctl instead of GET_DAXDEV
2. Use backing files infra for daxdev table
3. Use ioctl instead of GET_FMAP
4. Use backing files infra for fmaps

Request #1 was fulfilled in the v11 patch set.
Other requests were not fulfilled and with no explanation why,
not one that I could find anyway.

Perhaps requests 2-4 were lost in the spam folder and/or lost
in translation, so I will repeat my question from review of [1]:

Are there any other *technical* problems that you can point out
with the patches that Miklos posted (including FUSE_DEV_IOC_STRIPE_OPEN)?

Thanks,
Amir.
