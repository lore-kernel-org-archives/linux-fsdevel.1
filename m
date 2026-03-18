Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD35355050
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857590; cv=pass; b=GYWr0fm6qw8xIcruTMugiGKZ437X7RzGO8r4FbRqszIuuaygoB88WW/oWpjX04o/wxcM6V+QROtgMCCTbkJiyrkSQMdD/TTSuFkjgk1F0RhU1R2ZrqWlvAwopyXf0SnkT6P0/IWPpJwyt5VVZFsOqrDuXFXqxdrtIkkGb6NhbUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857590; c=relaxed/simple;
	bh=aYfQcyPd2JpMxNJXJjjDmoBHEPgvHNulsEHDB83Bgq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkyxMAh7fEQ7sN1Pwds5ia3qicOGFhUyaC8e2m1SOxOb80zKXNHuwrgSIOSSPCg9953dVzPyO9fQvo6Hx07Fjc3zv+F8MaVk65pIPc2NDGJQBkdgR7IGYIqtxPptSfH34fjyulnNTE5Qzsvf0p9XjjWaBbXsREFggQLPKunlEv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjm6p3jB; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjm6p3jB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso67416f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 11:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773857588; cv=none;
        d=google.com; s=arc-20240605;
        b=PvP4+UuZqD4f8XN0U/cOnG6PjJ6sXuuAhZo7w7DIzM8iOX7mbU6ijBVvAJHEyanY3C
         o3L+r6yu5Qa0GD2fPV8n6KSfXhu8IDpR2nsb43CK1sd8PMlaUF02nH4LHrKlECkgdS4d
         0q37/PYevk5gF9O38ymuqTqt404+fJHh4cQkoONnQCy9XKPoEwQTSraKpnsiZzyPtzTg
         ++WmMkjwOVy6sEumKH4yHoAnkS/gI+c6KsRg2U4Ci4gPD5NwjJgbil8Om6txV2GDhw6C
         itYXL5ej2Vfakg6M+KPSFfgJGuCbKpl5mRY22HBtGlO7o5PGJt+59+VjCc2o3CU+BTVR
         yefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uqj5XMGw7cCcB6Nmv8ELnKOv5Ym70pXtx/KbzE/luvk=;
        fh=XE5r418vEQdjx5ORRe8/zCipabi53Q1Xkwet6jIL4wo=;
        b=SQMUHVzT0wqeh/X+KR+1U6SRqqo3LiJfaJ+b+1PC8y2hrrC+m0NMm231aGMUu1y/W+
         Fzs3UdSave+EfdoIbs7vCLTe3UT6nSGwmX5nZQabx2nFY+aYxOdDepDv3hdaafUPn8PM
         VIvLMDWh4oMPckLOqDAAJu7LQFlj8OTk4GSRPmMIUGTQbdOsdCV9Y6V1ers+bRlbjk+2
         hSrT5UCwGTltb1KTnzwVMtT2yeN6NyCebVUY5mzKZMHLE/d8vfvJg/kldOtYFxaRzRSY
         sjTfNdw5sCr93kNdeUmIl06n17+v8kswRT8AoiZxUYntR/akofDVRAFRw5PACezpdfKG
         u2qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773857588; x=1774462388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqj5XMGw7cCcB6Nmv8ELnKOv5Ym70pXtx/KbzE/luvk=;
        b=kjm6p3jBGILhijUqvEwOnNHuFaQ3RyycIxcrpuyc4R6TiWUUYZWMNL+2VVe5VL5yfo
         vKqXeaIZjc06aJ7qf5KLa+nrPhCNHXdDeCoq0P3xw6JgqEzdE2xh5qplnfWPXhuQzfOE
         XwOo2/nAkI4G9fpQt/TTBAKQv+C2D/913GTLzyDkbcxNdy+QMb58pl4W0QhMs+fYT5ZY
         4AfR8Ikll+9Ghqlhh5pL2TbAGFxm28Zx1wa8nwM7hc8O/bbzRD7+TWLB6xi2gP/lR2HA
         YenO9tiHkZYaD2rb6N/iWyMAaf6l3QdJ9j3v1x3F9Uat6QK1vZjgJ7Q0Fz9cINgNlTih
         PN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857588; x=1774462388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uqj5XMGw7cCcB6Nmv8ELnKOv5Ym70pXtx/KbzE/luvk=;
        b=JEkEoMa2PKELXe0h4MWdpTisvcDx5QSarHqjZHMsUdyTGEIRCOyIXTwOGxvSWljxG2
         hYofMzUWfTlO7nhr1yjC/8IJ5/fvH/VS1m4z8OKQkqBsQx7Kon8hGtow+tNgzC3EjTxE
         RzvUP4HknPGMFIvws2GcEP6A5SSchWFVCHbElrkTxlupFi7yWlNRZsIVCsQksJZY9h6n
         +GaUZQnebtTC+V24yQvVHf0Wx9McHAg0UmGql42dBe/JEZgHFArUqNT8ILx0aNSi+Tn0
         jw5/7P52/ViTqRWhh+PFiaUHhocJFsaiyMEP6bnLwXkxH0M5vvTtEx5uXvMD9bIm9NcO
         6klA==
X-Forwarded-Encrypted: i=1; AJvYcCWWAWTfIau+QcDnModtGz3z5r3vNtSDfoENGguWUG/kuHtFbNFzsHTdNXAP8oTtAEDHvBqAGor5Ao7B8UI7@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVF4Y9CK2yGUPX7+2+ADyenj9lggVSDlATR5xKDWECEdF0Zc5
	rLyjTj76T8t8iY1ZTuPHMEoVG5O8+TzdvOj1LzUUJASolMbKwau466VPnKbJIG4c+fA3U1kop0F
	6+BeUAsBQ3qxUnCPRnfh4yLQnGPKWoSFFd2T6
X-Gm-Gg: ATEYQzxOBsYKA43RwFPywTIBKatkaK//TQghjd7jgXADRo7/yaoQAgECr8MzTG0En7m
	AnqQvoCnvigdGxrepBdiN6FEkoHuCeitKkuFmjWftHm9oMxKhHc976VTXRDXMC5iYKj/CYtENmq
	J/ulVGSPILteBsTTuGydMqblDnUGCLnryunuagMTDOB2WfV2hLIraFA0xWGp3QqqFRhQejGOROm
	uWWADjBG+CWr+jAEjtUU+kNmAqzU/Wq28XIo/siwRzxHNpnELq+TK6z91H3Ka4imudiywRVStbF
	36QDFw==
X-Received: by 2002:a05:600c:4703:b0:485:ae14:8187 with SMTP id
 5b1f17b1804b1-486f441fc66mr75580475e9.2.1773857587533; Wed, 18 Mar 2026
 11:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
In-Reply-To: <20250617221456.888231-1-paullawrence@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 11:12:56 -0700
X-Gm-Features: AaiRm529ChszMUbWQZJ_nWsgFZIqx5ZMKRWtA3d8zBn5YctL16e3n_Wnw9zHa4g
Message-ID: <CAJnrk1YWd9HvVLTtZDEM=XyOaPvkuSF8O5uOu9k=m=tUREsw-A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:15=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
>
> This is the first part of a much larger patch set that would allow a dire=
ctory
> to be marked =E2=80=98passthrough=E2=80=99. At a high level, the fuse dae=
mon can return an
> optional extra argument to FUSE_LOOKUP that contains an fd. Extra fields =
are
> added to the fuse_dentry, fuse_inode and fuse_file structs to have a back=
ing
> path, inode and file respectively. When fuse is performing an operation, =
it will
> check for the existence of a backing object and if it exists forward the
> operation to the backing object.
>
> These two patches add the core infrastructure, handling of the extra argu=
ment
> response to lookup, and forwarding open, flush and close to the backing f=
ile.
> This is sufficient to validate the concept.
>
> The questions I have:
>
> * Is this something that interests the fuse maintainers and community?
> * Is this approach the correct one?
> * (if we agree yes to 1 & 2) Detailed analysis of the patches for errors.
>
> A few observations:
>
> I have matched backing objects to their fuse objects. Currently fuse pass=
through
> puts a backing file into the fuse inode. I=E2=80=99m not quite sure why t=
his was done -
> it seems to have been a very late change in the passthrough patch sets wh=
ich
> happened without comment. It does not really make sense for full director=
y
> passthrough since unopened inodes still need to have backing inodes. The =
one
> advantage I can see is that it reduces the number of opens/closes of the =
backing
> file. However, this may also be a disadvantage - it moves closes, in part=
icular,
> to an arbitrary point when the inode is flushed from cache.
>
> Backing operations need to happen in the context of the daemon, not the c=
aller.
> (I am a firm believer of this principle.) This is not yet implemented, an=
d is
> not (currently, and unfortunately) the way Android uses passthough. It is=
 not
> hard to do, and if these patches are otherwise acceptable, will be added.
>
> There was a long discussion about the security issues of using an fd retu=
rned
> from the fuse daemon in the context of fuse passthrough, and the end solu=
tion
> was to use an ioctl to set the backing file. I have used the previously-r=
ejected
> approach of passing the fd in a struct in the fuse_daemon response. My de=
fense
> of this approach is
>
> * The fd is simply used to pull out the path and inode
> * All operations are revalidated
> * Thus there is no risk even if a privileged process with a protected fd =
is
> tricked into passing that fd back in this structure.
>
> I=E2=80=99m sure we will discuss this at length if this patch set is othe=
rwise deemed
> valuable, and I am certainly not wedded to this approach.
>
> I have written tests to validate this approach using tools/testing/selfte=
sts. I
> don=E2=80=99t want this patch set to get derailed by a discussion of the =
way I wrote the
> tests, so I have not included them. I am very open to any and every sugge=
stion
> as to how (and where) tests should be written for these patches.
>
> Paul Lawrence (2):
>   fuse: Add backing file option to lookup
>   fuse: open/close backing file
>
>  fs/fuse/Kconfig           |  13 +++++
>  fs/fuse/Makefile          |   1 +
>  fs/fuse/backing.c         |  97 ++++++++++++++++++++++++++++++++
>  fs/fuse/dev.c             |  14 +++++
>  fs/fuse/dir.c             | 108 +++++++++++++++++++++++++-----------
>  fs/fuse/file.c            |  34 ++++++++----
>  fs/fuse/fuse_i.h          |  61 +++++++++++++++++++-
>  fs/fuse/inode.c           | 114 ++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/fuse.h |   4 ++
>  9 files changed, 392 insertions(+), 54 deletions(-)
>  create mode 100644 fs/fuse/backing.c
>

Hi Paul,

Are you still planning to continue work on this series? We have some
internal users at Meta who need this feature. I'm happy to pick this
up if you're no longer working on it, or collaborate if you'd prefer.

Thanks,
Joanne
> --
> 2.49.0.1112.g889b7c5bd8-goog
>
>
