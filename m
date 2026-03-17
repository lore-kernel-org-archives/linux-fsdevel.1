Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626938C41D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732376; cv=pass; b=eUS7zQNH2HxzphkS6BlyiEm5GyCPoOFDg6LsWIW4utxH+6wqqcIB/pZIszL06h6xZUFTnlXateptn2BPo3SyUhqNwu0+eQ+vjUuWn91X8A6DyElezLVuiKEkDroqW33mDgVGA/JI+B7/5U63/4+M/N0afV3IFcol1iqVIvbUrsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732376; c=relaxed/simple;
	bh=f8UETNxqUQnzPIAZtG43HfP4bjrDwk0GJJOmlIbeQc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTTQJWN2Kf1efG/rTdFhVvQ4Ov9BQt5tmJQmbpV3rN8A1Wal/48FUYgkPKyEOMVwtbOpzQWz5UNSciBdME6dcgigTRAgCeLsypHWzrQEh9jZW2+9O87kWUheQm6KcR6URjJhU8UTKKVNE/RjvRvX4Y0Cz3VPQE6cjZ0YQTWufb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGjkNiln; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGjkNiln"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9789425fc5so62962666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 00:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773732372; cv=none;
        d=google.com; s=arc-20240605;
        b=iZx5UOHb29VRkbcehITd5LFIQFnSTJeYfC9+E5zCi1xHa/p7fEB887tDwPwT6yIHQ5
         opLj72XAAbNdJOy8cJLdJqvYGT/tnYy49UvqJeMTqP5XkOwjO3H0sRGKWuZnLgt6bvFR
         9KcbtEIo8KGuvqeYV5OPtHOYqjR9SctuEMwKvQ3xc5zgDwS+tlH6c+ffzl+zi5ovOnQ0
         RUdxgWnXTgm9U+7Q05oGhg91x9Tzv306DyhtetYfGJ93++BlTVXPkQN96Ujj+f4vtk/Z
         1SXhBotOJFoJ++LZyJuPmcNvxMueABO3eSQ88HopOaK9ReOI305B64tohi5I3IEIigwB
         3O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        fh=jakgaYeMS6N8f1jCkhQo4viAHD27hxn4eTcJqnoiCEc=;
        b=bNCQC/QyuN9zkmRuquULdZzuZAShTdKyIyzdo6AoVWyEHzzxv8cEn4waXhPCKDu/sd
         kU7vWm/vra803JIWY1CLoLE18cFIkk5xFVfBaG6HNMK3CAEq+IUOPu0INRM279fEvDn2
         dJ7z0Aj3v/v73ActhTKwF0rpxLcnurwa37f9hdWLAWYyT1AJ791UWqHmxr9dH1/YS7Ng
         F9PbGj7tu/81GDkXyEQV5bXpxwYR0iu5cxU5rY0wYfORSb4i6aDFE97i0FBmrUkvWXFE
         PZ2K5LJdKj3yJF+eq02N4HOegjrhmd5/OSi/DIjosY48Noe976e+K3Xhe8MMEJr5VtHU
         RPCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773732372; x=1774337172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=TGjkNilnWLGvnVVETbbI+TTJD6At4Tcc0N2XhWRm162KPV0KehCLfltBPpboGCf1hF
         SDTakddI2G70h2P4hVJeZK01D3T3VYvWyHqk2fUlvp76PMKf0DNpM6022lpEQ/cTWBYe
         UkR6rhiIEOXqAGK6105CDMUD8J+H+4LspFV0iFVLaDyEV8UTMej0KWYOzvHw+VGp5WDK
         ne3ViYov1uuldf3cOs6mfG/h/gWnbmJwe+f+MgpCbjX/RSzxPFUhIS+aNSnTOmlFbcSB
         du9b2n/b3n8NyZG3TrPWmna6zi2Brh1voYaRbHegojj2qDyV/5fOS59gXorYFiSy8cbJ
         26kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773732372; x=1774337172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=nLqruDaxkFFVTX46SGYH+xxhNKbKzweQqleOxcLFXisRl1Bvoaup1mWKUslmwLZZvo
         SwTrG4fHD9sgZ8rUbbF/KWXVpNHjle7pCtfP4aP7lHdQchQtYbxqVNBJRn2yG3enkN8M
         v37n23eOq8cC7vS60wTKrtrS+t8zsc3Kxn9LXEY7V9rVEzKL6Re8Dns8bTVdd+IzipQz
         CD5X7ODfCMjxvK31l6q+HnJ8zYk49AWTTrviqQ47dym+Dxod7q3hu8odAh450MGsXV2Q
         CGtOuNQFpUo/gTKvRuXPYnABxcMvF9LFhtZFs7Ja4zO731La8VwLHIH0ig6MQtFqhsPA
         wR6g==
X-Forwarded-Encrypted: i=1; AJvYcCV7Fd5h3xV3PFu9pxQe5+w4cp69U4UxviMnZYZ2n3o+F6La5+kMVY8FxTHoA8rtLo1HcPT429mOB0uOQSdh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07x3gCOs/mPrIFI5e6r2JbAN1uE3HQb9mZ6vBdJpNog6hxDUx
	Uqq3CRdBheMBD6Wq5fDD5vzoFUn1wnc7kClznbEXSa4EjwIL/xB5mNU0G1xX3meaud8SQLlGACq
	WIuvZ1i9crNdL/nWIzZEqactJoSc4LoM=
X-Gm-Gg: ATEYQzwFxwlNf8eYmy/KKnFSM2XlwwQ990k9mUgY/J1ZzeSgDq/NZ0b65+MhwdJraLA
	3lhbqpaTBLUqzCH0+i9WH4FMlIBQAIu+fbzV0YmkkuotX+Z9m3wLTJ24dIfehc96xFNzSTVphM5
	/rb8W73E1hkKDgOEogA9zcnNjW73uT14/SZuMWuHtRu/jsUvl+7Kfrb8msWjiIbpm5QcWC5Ww0J
	G7EaNQJPsgywpaCOCuw/6dMT5XO2C5rZjTPsbQWEiPrt8GCiZrLSVhofohWikpVsLtEQD4W2D2I
	UMEOXXFv2HJc3v36evNdDNpU7I60y/SZMruXDUXy
X-Received: by 2002:a17:907:3d03:b0:b94:231f:26ca with SMTP id
 a640c23a62f3a-b97d6d99d0fmr133734066b.20.1773732371166; Tue, 17 Mar 2026
 00:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
In-Reply-To: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Mar 2026 08:25:58 +0100
X-Gm-Features: AaiRm50sF1v33VMxCQO8F4CAvv3PlKmjLZTCcf_1PYwrrTaEu5VQoATkjlrFBkw
Message-ID: <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing mmap() and mprotect() LSM access control points for the
> > overlayfs filesystem are incomplete in that they do not cover both the
> > user and backing files.  This patchset corrects this through the additi=
on
> > of a new backing file specific LSM hook, security_mmap_backing_file(),
> > a new user path file associated with a backing file that can be used by
> > LSMs in the security_file_mprotect() code path, and the associated
> > SELinux code changes.
> >
> > The security_mmap_backing_file() hook is intended to allow LSMs to appl=
y
> > access controls on mmap() operations accessing a backing file, similar =
to
> > the security_mmap_file() for user files.  Due to the details around the
> > accesses and the desire to distinguish between the two types of accesse=
s,
> > a new LSM hook was needed.  More information on this new hook can be
> > found in the associated patch.
> >
> > The new user path file replaces the existing user path stored in the
> > backing file.  This change was necessary to support LSM based access
> > controls in the mprotect() code path where only one file is accessible
> > via the vma->vm_file field.  Unfortunately, storing a reference to the
> > user file inside the backing file does not work due to the cyclic
> > ref counting so a stand-in was necessary, the new user O_PATH file.
> > This new O_PATH file is intended to be representative of the original
> > user file and can be used by LSMs to make access control decisions base=
d
> > on both the backing and user files.
> >
> > The SELinux changes in this patchset involve making use of the new
> > security_mmap_backing_file() hook and updating the existing mprotect()
> > access controls to take into account both the backing and user files.
> > These changes preserve the existing SELinux approach of allowing access
> > on overlayfs files if the current task has the necessary rights to the
> > user file and the mounting process has the necessary rights to the
> > underlying backing file.
> >
> > --
> > Amir Goldstein (1):
> >       backing_file: store user_path_file
> >
> > Paul Moore (2):
> >       lsm: add the security_mmap_backing_file() hook
> >       selinux: fix overlayfs mmap() and mprotect() access checks
> >
> >  fs/backing-file.c             |   28 +++++---
> >  fs/erofs/ishare.c             |   12 ++-
> >  fs/file_table.c               |   53 +++++++++++++---
> >  fs/fuse/passthrough.c         |    3
> >  fs/internal.h                 |    5 -
> >  fs/overlayfs/dir.c            |    3
> >  fs/overlayfs/file.c           |    1
> >  include/linux/backing-file.h  |   29 ++++++++-
> >  include/linux/file_ref.h      |   10 ---
> >  include/linux/lsm_audit.h     |    2
> >  include/linux/lsm_hook_defs.h |    2
> >  include/linux/security.h      |   10 +++
> >  security/security.c           |   25 +++++++
> >  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++-----=
-
> >  14 files changed, 231 insertions(+), 60 deletions(-)
>
> Due to the nature of the issue, I'm going to merge this into
> lsm/stable-7.0 in a few moments so the changes can get some testing in
> linux-next with the idea of sending this up to Linus' later in the
> week.  If anyone has any concerns over this patchset, please let me
> know as soon as possible.
>

Since previous 4 revisions were not posted to public list,
let me repeat my concern from v4:

On Fri, Mar 6, 2026 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Mar 6, 2026 at 3:24=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
...
> > My expectation is that the merge of this patch will be collaborated
> > with Christian ...
>
> Of course, that is one reason he is on the To/CC line.  More on this
> in my reply to your 0/4 comments.
>

I am sorry Paul. This must be a misunderstanding.

My expectation for collaborating the merge of my patch with
Christian was that an agreement would be reached regarding
which way it would be routed to Linus.

CC to Christian and sending the patch to Linus without getting any
ACK from Christian was not the way I expected this to go.

> > and that it will NOT be auto selected or rushed into stable.
>
> I haven't marked it with a 'Fixes:' tag or a stable Cc which in my
> experience are the two quickest ways to get pulled into a stable tree.
> I'm not sure what stable policy Al or Christian have for the VFS tree,
> but LSM and SELinux commits are not pulled into the stable trees
> unless explicitly marked with a stable Cc or requested by a dev after
> the fact.
>
> > I don't mind if you want to route the security_mmap_backing_file() hook=
s to
> > stable to use it for some simpler bandaid for stable, but rushing this
> > one to stable is not a good idea IMO.
>
> Once again, see my (upcoming) reply to your 0/4 comments.
>

TBH, I don't understand the logic of placing patches in lsm/stable-7.0
without the intent of backporting them to stable.

I perceive my patch as a risky patch for overlayfs and the vfs
this is why I wanted Christian do be part of the decision if and when
my patch is sent to Linus.

Thanks,
Amir.
