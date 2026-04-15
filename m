Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58E318B9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273190; cv=pass; b=tIrH52sjjEm+L5lCg4rLb1phHLCb6kcNHpOFxRRZWjlMkJiQ0TGJnMDTQstV0Qd1W0LdEqTbuxsegGJIRN9LpExZMPqingiOlgi/x+1o0PCRVA4jlUEoh+ap3a/vZyyEnoYqe0J8s1sLPsIFkdPY6Xf3F2IPiBizPmdNcxL2+8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273190; c=relaxed/simple;
	bh=wdhiL7zirIut6Om162VyHe/8jfVFe22PxHmav53dlqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQy9ITK7Q62DTc/vrY1Kf00xvAbUFoB2Otye13CBEQWHUFvB0eVErJDgB2nWhrCzL+PSqhW6/CpWQyBm0oecLaUkeSvcrQtnBMfHQ9MVPxEJuqQIhRapB7fZq14ArRnz4OgIPxViTR4A5VsknFAiQEkRCYjKO2aXkTBcegn7RHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjd3jeZl; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjd3jeZl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso2406145f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 10:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776273186; cv=none;
        d=google.com; s=arc-20240605;
        b=KUbsTyFduR0NMy1smU/vz3OwT1zrbK2UGVz3UFwgPMPtUpbOUs9UkCbDieSsrSOcnx
         B7ys9XSNj7QDWrnYAe6uo3afqGnyZaJ7oiSt7GH2mxJv9GUpuJ+OZWxf7mwcOb424jjY
         oHUeIxfsyFQvC3jePXTANOBetrKaffrDOle39wyWQGMLD27Of4Nhr5FpM/wY4yoy45eh
         7TyF1va3hHUES6LTyBL3HRy4bmIfmHMfPD0Sp3SY7ET+i8EOL7jVeShTqEG7fN4V49e7
         NbtQCbZ/dhdRA6CrwoVWwSNkImeq/PUKx7Ec5cUif+IKIjmqaxYmiFH657Gu5RnkHysK
         1ojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        fh=FTrMfGLYFj/dCauRsPJsr/ULN5OuTemlE8pCQZ1jAd4=;
        b=Tv3WMw2FNjK3EHAwTp90NR6hHVaOIIEIv0Czasg7xVnaXVHpciwsbN/80E/aMoz45L
         1dPGtBTDKLe3PqLHIppIn6DCW7C3dhsa/cs13gBaNg6h6xceztJLkaOWTyQ1zjxaRfXW
         v5IE5au8rK2sgKCzbL1kuvmczIsAS+6n35SaN73uHC4hUoBIK/9s3rc9+bicIlleTal4
         qbX7qCWA1WN5eojpbeyj1dbf3S15EBMbTNekD7y+fwPPJi/Q5yXdL2JBBKXPCstWwAUl
         vSKPAthU0MuI3IJmu6WeNXN0KLFSjz+pQh4jYzbt0V60P9NXG/8X9vDoEI1bYXLHBeJi
         8VuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776273186; x=1776877986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        b=Sjd3jeZl6y4erdjEHWhwMwBlGkfCpssIZA1lQqG8otVlIm8H+0jXvd8/PrrfVW9mgE
         4b+aXZ3tscCnZzN5xFX9RSrg5WKO/Hj34QUfAOTopi1Ghb2TOSbESPzLLDCRqqQevTzL
         23khlWTfYpSTPcyVJ93xMIiABXTI1vh0/u2y4j6P71dP21+1ZUZqBSBGiEeGrGaCL+ly
         3eTL+TZvb/1VKT7Ml8mtEtQ7XmHC002tV+oAiuJr8GOEQUgNhP/URKwprnyhoaffnaY0
         GSehVFeeIWcGfBVdSs7JilO67Nna89mOYZO3RyfYRdHMBi/OEI3l7ZWmGH1xBfKDUzpi
         3tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273186; x=1776877986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        b=ke1XKmSlTSqBPAAfYDjv27GR1vvtI/E8So8N4LIKg1bZGVIPUPfDQ03FipfzduSkdc
         F0oRnfaoMtwOu3aP3dQpj9T9J6+cXtHoi/ZfkUB1T/FLkt8JU44WeOId7nNuMxXks0cf
         l2udYv+xJIrZ+ug6GXxW+dxGwHZnLReWL3pRUZRuibFPPYQj1vu/VfZNacAC2mOwdpkF
         4DzW05cHiwazE44Hgd8P0qtAHxMkHBg5UhhBEJ/wMJ6/89FhwyAiBUwtNuVYdgJd/7DB
         HKXQo7cqEzRBmzjr69VdwYQd4JCSUBYVkhnBPXUf4y9l/Menn8pph1Tr0vNNHSeQD0Uj
         FgsA==
X-Forwarded-Encrypted: i=1; AFNElJ8TcysG3IJ1ZIy7+DBD7i3RFjdpDEsAyzTkghTb9VKbpP30eUokIVkRjVs8cqu+L6Hwu3eXuexoy+SMMnt7@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVJQYguNG+qikNNYaxJpmIXVHBnUmnhJGgNFWAb001wc6g53i
	oHCR8PHhXtLfSZYq5fhAwAwAyroTO3e2XUlVBAMBP01MDlQSLgW6T/cN0HPl/Q7EkDAh9rnU8+M
	NiwVMiYoD2brrCAXU49METCvlwRm3kmY=
X-Gm-Gg: AeBDieukCe3v7rwwRlZ+LCrftyTMTccQbkXBs6umk53v3trnH2rNQdFtES/rUjITe2W
	+Z4ooS3DYHbPK8UCn+jZQGPZDkEhoO+GoX+gYrolUDp8S75yt3GuTzHdZoNyEFfa9BEFLMu7Dld
	M5I5ZuAgP8rjS3J/eDXVGqtVvoIX1jzEp13WrePo5Am+KgtQUgXZjfX4wj4s4maLkSuqKnZdCXW
	eJU7Xsg6WXIqY7b3oy7P427A5FtphhRhN/gNJ/Fk1947Uss3AzyHcYLdbMWo51D1LtobGk90n0R
	oKwuas53kPHr+jL9
X-Received: by 2002:a05:6000:612:b0:43e:a81d:c475 with SMTP id
 ffacd0b85a97d-43ea81dc4d7mr10552860f8f.6.1776273185949; Wed, 15 Apr 2026
 10:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F> <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F> <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
 <ad-qSB4oL5D3S-ht@casper.infradead.org> <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
In-Reply-To: <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Apr 2026 10:12:54 -0700
X-Gm-Features: AQROBzBkUIPEeKz-diD1-ugS7vjNoU9GOhppKCAHhyQ-ncyX3_eObS7SHF41aIs
Message-ID: <CAJnrk1Z+uNjn+BcmpciqPZhxYXEJ5Zgh=uNCxt17WTkdOubbog@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 8:32=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Wed, Apr 15, 2026 at 04:10:00PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 15, 2026 at 04:04:50PM +0200, Miklos Szeredi wrote:
> > > On Wed, 15 Apr 2026 at 15:35, Gregory Price <gourry@gourry.net> wrote=
:
> > >
> > > > This was my first reaction when I realized the BPF program would be
> > > > controlling iomap return value in the fault path.  Big ol' (!)  pop=
ped
> > > > up over my head.
> > >
> > > I'm wondering which part of this triggers the big (!).
> > >
> > > BPF program being run in the fault path?
> > >
> > > Or that the return value from the BPF function is used as iomap?
> > >
> > > Or something else?
> >
> > If a BPF program controls what memory address a fault now allows access
> > to, who validates that this is a memory address within the purview of
> > the BPF program, and not, say, the address of the kernel page tables?
> >
> > (I have done no looking to determine if this is already considered)
>
> From an initial look at the existing bpf ops structures, I do not see
> any other struct with a similar (obvious) pattern - so it's not clear to
> me such a concern has been exposed elsewhere or directly addressed.
>
> There is a verifier step for the BPF program that in theory would
> validate the range matches the DAX ranges, but i think that only
> validates the types are right and only on load - I think the BPF
> program itself would be the address validater, which is a strong no.
>
> BPF folks please correct me if i'm off base here.
>
> My initial take is that it's a real concern a "bug" in a BPF program
> could let userland map arbitrary memory into userland page tables, and
> such an extension would not be a quick fix to the FAMFS problem.

If you're concerned about arbitrary addresses in the bpf path, you
should be equally concerned about the FUSE_GET_FMAP path that's in
this series, because they're functionally identical. The kernel trusts
userspace-provided addresses in both cases. If that's acceptable for
this series then it's acceptable for bpf too. You can't reject bpf on
security grounds without also rejecting the current approach.

Please take a look at the famfs bpf program [1] and compare that to
the logic in patch 6 in this series [2]. In both cases, iomap->addr
gets set to the address that was earlier specified by the userspace
famfs server. In the non-bpf path, the userspace server passes this
address through a FUSE_GET_FMAP request. In the bpf path, the
userspace server passes this address by updating the bpf hashmap from
userspace. There is no functional difference. Also btw, this is one of
the cases that I was referring to about the bpf path being more
helpful - in the bpf path, we avoid having to add a FUSE_FMAP opcode
to fuse (which will be used by no other server) and famfs gets to skip
2 extra context-switches that the FUSE_FMAP path otherwise entails.

As I understand it, famfs is gated behind CAP_SYS_RAWIO, which is a
highly privileged capability. To use iomap bpf, this would also
require similar high privileges.

Thanks,
Joanne

[1] https://github.com/joannekoong/libfuse/blob/444fa27fa9fd2118a0dc3329331=
97faf9bbf25aa/example/famfs.bpf.c
[2] https://lore.kernel.org/linux-fsdevel/0100019d43e79794-0eadcf5e-b659-43=
f7-8fdc-dec9f4ccce14-000000@email.amazonses.com/

>
> ~Gregory
