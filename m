Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE92494D8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233345; cv=pass; b=k39xzIkQvaUF+7cp56CdxpAMQvZkDteo7uIK3wKitisyJ0DcKKUrD9751sA5EnyVEk3B9MB/OicW4V3Q3/ICjKRhktPN+P0iRgdB3FQew9AnZL495luMzlOk3ROjg+TupdqgduPiHuHMwbxYx/B6obpBPy08B61wpXngYLXPoKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233345; c=relaxed/simple;
	bh=Lf4MAC55lAOec19tAL9RrUImgEkejoJyRibgvawRaa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqTVyz1+vdq++t+EdUYCMYUVEeJYFi2gkFyv5fvOgxqaqC6bNu5XOYuUujCV9L9gXOhrnbvBJRxlIhw/PohWa7wVHJ4AA3xTAexoR1dQId/koyI2C8UdPD/Ppvu6Nto0Ekz/ygsc2Y9vibL55hG0NiChmKIgAiUGYqapm3Xrdss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QwoNJ4Ot; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QwoNJ4Ot"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d75bfb259so11304291cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 02:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778233341; cv=none;
        d=google.com; s=arc-20240605;
        b=Coo1nDBbQeuwVEOgd+OH7KYrkz6Ew+q2Ll2qciT2MUMYA0TIPozvA8xUsx0q3J1nu4
         dstokHw6EljKBkyPR7UQnQ2mPB3W1Uo7ZDwV1JemIa8kFCA3hse4lVjBSEUQN8Dy0ZiM
         Ij4F7agTXygiDww/XzASHKs9L4Gl63RCojMv92HrJG0Bm4gcv8ZiVg8o9S76kNQZ4NpI
         bTF5TWE7Fou6zXDdhs9bROdGDs2OAvzN6+tJaCibX9lLkB5qCt2EJDv70LLNgvF0cRXp
         l+BDwi2c4HLu0Hs0nfVsA0iHKoeqEnQSDxFanPEwP5xCRbba2WqOsegCUK90/3wcfWRd
         1RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F+Ag+RgQmGLxPApkJv6LIm7lslO0K7aTyAwI9XqKQM0=;
        fh=AHYLQTk6vIXiQDKOnNqAl7LgtVONZC/0P5gKVn3vBrg=;
        b=Yg0LqBs6ZBt+tAxm77aU4+QTD15ABuuS/BAI8uSgqHMwRm7Rc2vV6jH9Mp42fIvm65
         5GiAo0lTEgjK7jJy4qZiF1G1hot7FJUfHUjkHtNVnaRiCg85hTmokOhbjMrNxGpTGD2u
         hjmvfKk+qP5J8Z0E8/zPZ7d9kRgg3521YCKo6IrC/Y4yCpLbiMOwcUR2lNgHXoQLs8PS
         SJm8fHjPi/uOevQKnSAIFIhp25keDH+RpXrhNCxHQpcbOFppVqfA6DFK1o9OdFwujK8z
         egsLbUcABDlwXWULBNYWjy+aWuUCW8M4zpYKewbzbqHcovjmgnr5ZEjDBzh2m6txKn44
         UNPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778233341; x=1778838141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Ag+RgQmGLxPApkJv6LIm7lslO0K7aTyAwI9XqKQM0=;
        b=QwoNJ4OttcQvASpzdEUauxpblDLw/ZpDYg7kqiaxBR6XS+2kA+sdr+1BjjAfUpOcwQ
         wvkKz0LzBqPOqYvLMcjA6nkrl9HlLMkIkMGShWhuKFdHLK/DgIQcP88yCF+0f75w+rwQ
         t4y9PBolcjI32VMmiGhcD3sibz9I7JPRZPJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778233341; x=1778838141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Ag+RgQmGLxPApkJv6LIm7lslO0K7aTyAwI9XqKQM0=;
        b=MThE5/iFp4YNtAoWEuE+I1ZjNCigR83maGEeJK+nMMgPi50YTuq5jyIfuHRjtwdclr
         jhqQ2/0d7xsOAjOvI7z9/BpVTxaewLJmcw46x7rrKDTGUop2WnT38GfYnJ+WfooiLkX7
         O8/9qZB996j9c4DskiPFLIIapUYNCSnfga9AEJgCtHZEB+D4J1VqZ/Hr5lXj5zxXZ2HY
         ta5Jr4UWO0iXA7ar/P6tLCnYPJdq5LutRQEkeQAuy9nt2mKNqvlJ8K13jmLe1AcupBVh
         kOypVelCwLAkF9fM5GuHXqBIP9De4ZyutCmcUbk1wdkts+VZDL25jku12twsfus7x8lR
         PH8g==
X-Gm-Message-State: AOJu0Yx+qr9rGuTH8KiCCv1yivbFaa4Hz2+ZlhsWsGGzrEIn09hgSHTq
	nyQBt0VRTOdMc+JoLVlfRH95uI7MHV/tOBH3rnY3GoVueIwskbcTC73cuQ7MVbbrmZxPBicpSwF
	qD9xezdfSx6enhe9FM9Dlw9FkIub093US/XrqdbdnEg==
X-Gm-Gg: AeBDietUu18oB83Rh5udWgHUVAtHsBzl/xBlt8zsU1pYx6ZI/Y9uTxobsdS5ke+VNrN
	lro5I2O1UDvcIMgAbnL6QXhkFtJ7IXqyemNuenZ90Vq442Tu2huPAYuy9DB0rnOiCS5B90bSWI1
	uqSYu9F+ErvkMj1FnUSsdPCtDk5PEZHzQUdTGbxA3nY49/BYDYDEgmUkUcBOXwtqhzAp0yFZukW
	lVBFP+/HFgz2EAY5WqJ1RqkQHmk1pjTe2gWp6V8Dk3mvn0TBrxh18k+ClZsaYxCJX/IKF2dTI0G
	mvqwS+As+ZdE46SiVf7hH2qbv+ka+HhtBRr1Fw==
X-Received: by 2002:a05:622a:4016:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-51461bea508mr153318161cf.3.1778233341541; Fri, 08 May 2026
 02:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com> <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 May 2026 11:42:10 +0200
X-Gm-Features: AVHnY4Ij0Ire3MAWEQiBcsWG_9EdTD3zoQD3nOkow39AT2iktVxrgGC95EvY0MM
Message-ID: <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wrote:
> Miklos, could you share your thoughts on this? Are you in favor of
> disabling default strictlimiting? Or do you prefer to have it kept
> enabled by default, with some mount option or sysctl added for
> privileged servers to be able to disable strictlimiting + enable large
> folios if they use the writeback cache?

So what I think we should do is implement some sort of slow writer
test, and see what happens with and without strictlimit.

Tried to ask claude to do this for me, but not getting very far.

So if I take this maintainership role seriously and not let myself
drown in the details, then the logical thing to do is to delegate ;)
Which is hard (for me at least) but I'll give it a try...

Could you please check how things change if there's limited writeback
rate and we disable strictlimit?  And what happens if there are
several such instances running in parallel?

Thanks,
Miklos
