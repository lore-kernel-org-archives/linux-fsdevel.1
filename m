Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F43DC4D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932054; cv=pass; b=NSn28enk1W7HoZQLnLY+0R0Q9BaoC2PHazCOYSvml35aBcW3iNBL9BuG1CqZLz8HrRp8VunKTN7H0xHx3LogCkZn8YuHYtZuqVTJQa/yDMX1AQDRrrJGxv1RV8ZrREy2mabd9Xewur/cUWK+I7RHGk7rWc6ErXhE+ll2MSJAAlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932054; c=relaxed/simple;
	bh=UmN42XIFxWPA+oc5RV+ztiTu/o/KFtkvvg5unw0jZ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrkT6mpv1m2PHce5NcNHZ8SR0IQsiryTiWPK34gXjS0fDMQ7n9yJmT5CDOL/OntpSP8mLlqH6JcMxWiL1YoKvFr30I4jLWPDYEMoZOrVQPBO632rv2tATImnbU+6a+sOBz4TdbyCICWu1cfotTA6XMgg5GsypLRLEMWYxNejvTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXdDk7A7; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXdDk7A7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b980c65b97aso130208366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 07:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932050; cv=none;
        d=google.com; s=arc-20240605;
        b=FBOgzyoX1247a1IqlXz7ziZP7F+TtyzC2IkTFfX10Fw2G+9wr22LDJMaGcd3k45wuY
         0i6vA+TyfqRtIijsxfWYwjN+jZ7Tfe+AADObgxdJcpc1fNX15UTjb484vX9rPuRTvi9O
         y9DiQoQEpkPnE6CMzShc+UhT0YACWpglmuA4MNHk5BIjreJxq/0t0xDgKFkKNAlQrubL
         hTc9DN0qSGaXzhW6o61d1F4E/cRQgJQCDzSNBCK4BeRyxXRfc2r1nplRzGbB2u4lTp5C
         KzVJUW91LaIn4bR05aA3M2JEvVy4ZV0XgMrdtOo+Si6gAEjQPox/PdqegsfQ9bcynEcA
         da4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        fh=qaXa2LzFPjAIR3cWRo6/NMNpk23mT6H0BOP61A/x6Bw=;
        b=fcDgUrCDOuRakxwXVzOWlERlzqJ6TUpkCPGwPSN2V/+rxu0SIG1uluoxVfwpkyDyXW
         36pZz3ouMh0SvSvPttwMAm4U/tMXwcfp1wcLAucRzKHTeXeWt7pp7+XuqoUqGIQSiyJE
         bBoS0La/hPav/TUK5HB4QN7+kymQKSMubvGjumVOn/W9pluJr0iat5Sn27MPUwUysbZF
         Uyejbt37avlINMRplL5kNE9l/bThPw5eWsOgqTzQUU2qzxQCD32GzE1IDzVU5T77OdwS
         0312IidL8U2f6Yn5cVRLJv1q3wFWv2nFBRs1w6kMAl8e+iZP+If29eCpsDDHfdTD5enu
         k6/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932050; x=1774536850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=hXdDk7A7vGYw3Zx6tF71xgZ7WwjEnaSx5y641xv65jo7qeQ8m8GRnNgGYdbd7kyl6R
         jJrYRxgyKtVCKK4gWldoBp3Tvv5JIfA34Qk+AUM+Tc1yNVtKuQOzEjlcqKADPmBmdM8w
         Abw0s9L2n45ICgImp7PJzWtFr3S9gAQrMEjvGWASPn8mFsb6ObKzNoAMwTU0IXbMD2wE
         RqECz/OvszbdyuC1gWzGfiUkUSZgpXR6vJXzxNUgUd6dbCF/7aJ293WWUo3p4R/57EBl
         UZcoxF6Zh44ecjSgAzXPCdgTQ7czPzt94DSczCXot4iFxD9ZleUU1yD7bhYc660LKoOY
         FQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932050; x=1774536850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=tQ741uuB7GFNUO91CDnpmv4bUYI6GEy+Q9G/bN7w5ETo145fSHBWoem8ksxXLFkcDh
         bQRYOKR6nNVSAjyfduN9Rp1w5iDnMM0s5PxNmYu5mS0xtlCfjH7yvqSSijbWGYkEv/05
         A6i7Y9M0SBoE7lp/Bx88MvMMysGdk99YhgzDVvDe9kJ2YTETEQoZErB//g0wgGaJjUMQ
         synet1LYIUucSl+4F9SP8BBPtBx8H1vs27LZd4So6fvAU/tlJMS9rMtAf7itU3Ea3G0q
         +av/dhreP58QzkSM6JHSd/1cx2aUe82QITA8D3VzcMysAfSKHnouY+pRjx+BjBJeseE3
         gVTA==
X-Forwarded-Encrypted: i=1; AJvYcCXgx4kioZfzl2NpQa2p2KYX+2BvgfW7Dy20IwwRqGRxHZCn8Ry9SilVDF+J32BifOhK5cjawuSmM/WIdueK@vger.kernel.org
X-Gm-Message-State: AOJu0YyzluoqfoCQE2lcs2a1dXe6SS06Myu3ZqaVddhZkPHfGHrIVutg
	l4Vmbf8Bu8tBcKT/DUx6QhnFpsU6Nk8GZn5ArVY2byDMueqEtRX69i2/YfZOnCI5EnHssaDthER
	7hlS/ayypFEDOELy62y+tAwPPhaQoGqQ=
X-Gm-Gg: ATEYQzxoVw3qFHr4yCFtj3QTxQud6g02+eCoAFh0uLxwNED9JNgwWKpsWZwq7hyLn+O
	ry1pOLm93E+e/ZRCb2gxeKvmhNJLB0eoJP8rxVi+zfDx6L8xDeXX8cRj8e+kJyg2DMolOdNJOcP
	+QjU2YSrGfVSmehkdCjGDERoNMOJUx1u1AJoWLF5nVgky9utdUgWE83aBEEmnoGs6ynQugXvYet
	Y6grJYlewnjbW7sQ4OBHq9nBZTdHD1PQELzayA54FZcEWNfyvivDaYpJR2kq84Yq26KiSQBDS50
	redm2UYvQvQf9BLVRvvRzE9ufA5ItY0L6kr9xGRXeRdkhmbLlAw+
X-Received: by 2002:a17:906:945:b0:b97:d76f:3790 with SMTP id
 a640c23a62f3a-b97f4948e4dmr422735566b.24.1773932049652; Thu, 19 Mar 2026
 07:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
In-Reply-To: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:53:58 +0100
X-Gm-Features: AaiRm53ob940soSsJtP2tgmiMXVCsKvszmwMYDw08PfOi4CUawSVTSX4zhGKxzI
Message-ID: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The file_ref_init() helper was changed to accept the FILE_REF_ constant
> > instead of the fake +1 integer count.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > Here are the changes you requested.
> >
> > I removed the ACKs and Tested-by because of the changes.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v5:
> > - Restore file_ref_init() helper without refcnt -1 offset
> > - Future proofing errors from backing_file_open_user_path()
> >
> > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.c=
om/
> >
> >  fs/backing-file.c            | 26 ++++++++++--------
> >  fs/erofs/ishare.c            | 13 +++++++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     |  4 +--
> >  9 files changed, 103 insertions(+), 34 deletions(-)
>
> Still works for me.  I'm going to update lsm/stable-7.0 with this
> patch so we can get some more linux-next testing.
>
> Tested-by: Paul Moore <paul@paul-moore.com>
>

Paul,

As you saw, syzbot found a nasty bug in this patch and it is too hard
to fix it without introducing more hazards.

Therefore, per Christian's request I am withdrawing this patch.

Please see compile tested alternative solution for selinux without
intrusive vfs change at:
https://github.com/amir73il/linux/commits/user_path_file/

Thanks,
Amir.
