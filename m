Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8D31E842
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854127; cv=pass; b=i/U1VUof/R+BFxF9HuJueMB+e8dM/v1UnsK1bgbDlV/XkojbHYsPgl5/xzfmo+rVJuMzKdiBwQRCtRNzHTHtuZ6gQehOLCRcx4QC+jmBbQ3XCYCP6q63J+9jzHZMI//BflGaBtaYbMeEhm2dHnUP2eQM3zHvT32q0a6b7XL7ROc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854127; c=relaxed/simple;
	bh=PLjuf5U1Ldp+lKMspivltGTyqfvutQwDbWwFfF6CvPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQSEMr2QZw3D9xiTJO0BgARTeL9oYOaReRFJeNz8mG9dERfHfBL2eE+PJ3OEnek4lNpMVjh9wdgKbMh4+epi1X7pgzdN5KXQwGgMwzKXbrNQiQCl2nDUSPMp83Mbg8POsT90Q+s8lUQgmfMectezZEl4aV1dS6/S1KddTT+k2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKTQcXfm; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKTQcXfm"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-695427c153fso2478253a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 00:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781854123; cv=none;
        d=google.com; s=arc-20240605;
        b=UX7pVOjHtYTnbX5ZAdLWQ4k1QA8KfJEHb6cHgnozlao1m2Pec01vjubWC5kjwxMlop
         Auc89x/AZ3xRdRaz67CHf9ZJ9wyabiInSFpbWil08lvIrGSA2HdQxnT5xaeN5LLEdD+M
         ITR9ePmiExAY0J5z+J6RSGu0NqWTkFKVVesCZw2BKq6+sU/+PTOztbFq7hqcamjydZ9t
         m7sxuMY9sAqKJ54yilUtI01Zzbq9TBJ0/ap1J4gcwHUxR+Oq17EPEdKoFr2Bg+hwGrRd
         GWg6eeC5yfYp/rjzzqA6LOlF3b3Tom85rinqK681+eITfVJJ6mZESY+FvnNwl2o4rDkx
         rSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXsAttpCRAfo1jUwXpOflkS7AbE4OJcRHMhxuP67MIc=;
        fh=e3vf2w3vNY8g1sz4yBHy6JSAtjquh0i05aLDSI20jCM=;
        b=RPvQzfGNpozcCCIHTWbvaBiqFGMDxh2JdYor7YcRghttp1Ml4MLK7rqjH1mQHm2FWT
         ZAxw4Kp/I8Yl2uMeue9fBX+gUZlBD+mVjw2p79ZLcOMhN4PUBt5z69Ztp6EuGsETFChx
         k1ReeU4c44k03xzTJz2CFxvrICTjKtnu5/K4l7DHiR0enG+MxpCwiMvIlWYTKpPtCVC4
         Pw+SsF4rvyb52RAfC46YVuN3Azg274oNTdmZ6QxO0ji74mQiRcUtcIFcCxBu5DGl0t9h
         ANtm6hbINpoizYWeIse7SyxgW6q3q4RStIO5npvvSFOLW27DxcyDDzL/G7t1Bt4CS3mW
         0T4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854123; x=1782458923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXsAttpCRAfo1jUwXpOflkS7AbE4OJcRHMhxuP67MIc=;
        b=EKTQcXfmTpSi/O7oXABloqzK4/JL++I7lANtSI92FSwbPSaHSyI+Ly8uLgGGwc1czJ
         YtYQI1UH6Uizdt0GwLZqdw2hO65NG7CfVB0eP71OayhIh1bgU1DaOg15/9a9kMa2zgBW
         zdQNfNRTcXpnOjFC0pWD2Qy8AAunFSt5GVlRmax9ecbpzBv06uE4YFJ4+8celdU/Mj1B
         MGNL1NDGi6M4Os0QZhfGMRwpocG1MmdFdOgNugrBvNpnHeADOFto20dQ5EA6cQgJtC5/
         S6OL7JKPrJ0cmvFh1esu4XnUeP+wn0wTEaOxYUfcyAwVCO0NjXfBZnXTUOLQKFc0fC2I
         AXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854123; x=1782458923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXsAttpCRAfo1jUwXpOflkS7AbE4OJcRHMhxuP67MIc=;
        b=CzfuFKcIJEKz/uc33QiGdI2zWnAqtgKen/5jYFDSBkiRI8hGhA5bV/ZQiPKj+g4rbs
         mQijknwogtaNXDmkX9d2okl/HRXNc5cxCC2jPnJcnL2T7Ui6Zpvy6w8odWUV+25sqaEb
         5zViAuxLU5UJJDvnIszPMCL29STDfnUYkQjE+1QmmziTfvkUEiiG4BMxpPb23V7qyXYU
         HJYfp4HRNlBWZt3ytJYCfLsBFc2SC+1INHnmxpw2iiAvuKWETbLAWoMkr1+TPR5KHptB
         IiWP6oKaE7k3FXRwjY09I1yuGgH84AliwhLfZzPyEZHEOTwld5fzDMDUc9G2m2bQR5eC
         fmVg==
X-Forwarded-Encrypted: i=1; AFNElJ81U/C2j0jpqAGstnZPPUY5sTSYILmwbi9iccCZfN4bJrQV1mreGjxVwX/+bHels+/UGE+r/bEefVpKu1NI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfm1EryPHILqJZPZOHqJHPjX7CcSL7q2aFTVO2fsxmMURpemse
	6z4OIup4L6zWKa2Sb5Gsy1qZukru+z2pX8tfCd7L5rHrs5ASsKlo0CuNizYzjnK4FUDKeXwmxAC
	6H+rllNJ9LzBK35hlKKVEsqxQq0NiJ9QulWwsOVs=
X-Gm-Gg: AfdE7cliWOXFkJyqSog2eobaDGWbH17xGFP+ol08kGqgnkPVeQHgKQjM0sldL+cmv69
	s+fjJRQlYbW4lA35yZMMgCGZm9T4yr2fzbcybgAYbmsBuoX5M1yWiw1I3DTN7ze9jhZuFcBPqH7
	DMFCPQX3FiLf7XoBUmua+7DAiwLN4A0V9qG5h7UqizQ8ELsAbzREvDyMSP3IH+CkgAWdjHNpcin
	sVqm6e4QKBToiaqCi2qDTVYvk7HefVa8oz+IQGAI4GS2sOitjdxT7JqboCC2iRDLonamKI4C7dH
	n7YfOu0yNZhdYPrnZyGraZKs8+iQYFaBon2Ie1aUyQ==
X-Received: by 2002:a05:6402:5107:b0:695:572a:7ab5 with SMTP id
 4fb4d7f45d1cf-69711e00675mr1216968a12.19.1781854123208; Fri, 19 Jun 2026
 00:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520123722.405752-1-aalbersh@kernel.org> <20260520123722.405752-4-aalbersh@kernel.org>
 <20260520190719.GB3424023@google.com>
In-Reply-To: <20260520190719.GB3424023@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jun 2026 09:28:31 +0200
X-Gm-Features: AVVi8CcyPPKNjODd0CeG8qbXXsZeOsRanxA9PmKFMYeTLACw7w0uBX2gqOCDc0w
Message-ID: <CAOQ4uxh_hfiSwMw8ABhhrz7GguZWjHEiBmvb3eq16Wfqw0+ZrQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/22] ovl: use core fsverity ensure info interface
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 9:07=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Wed, May 20, 2026 at 02:37:01PM +0200, Andrey Albershteyn wrote:
> > fsverity now exposes fsverity_ensure_verity_info() which could be used
> > instead of opening file to ensure that fsverity info is loaded and
> > attached to inode.
> >
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/overlayfs/util.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
>
> I'm still confused by the new implementation of fsverity_active() that
> got introduced by "fsverity: use a hashtable to find the fsverity_info",
> though.  I should have caught this during review of that commit.  For
> one its comment is outdated, but also the memory barrier seems to be
> specific to the fsverity_get_info() caller and probably should be moved
> to there.  Anyway, that's not directly related to this patch.

Eric, Andrey,

Did you see the Sashiko review for this patch and others in this series?

https://sashiko.dev/#/patchset/20260520123722.405752-1-aalbersh%40kernel.or=
g

It annotated some review comments as high and critical.
For this patch it is about interaction with fscrypt.

Please take a look and say if this is concerning or false positive.

Thanks,
Amir.
