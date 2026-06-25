Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC862D94B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421407; cv=pass; b=TQgOKGM/URdtnQyC9J9P1YLWgXlU+JxJ3y2jW5vcpxRYvUJNOs+WxDOUarXXDeQPjG67XvGLsSTuTsNAtcOtP2CilvX3F8mATjtxpFIS0eLG1XIhstoMflVDKb+40feo261fedvIU/wUkYXSHylN0p+MP9Hgg2JPRJqUgTV1qcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421407; c=relaxed/simple;
	bh=8X2qkSio5qy3f6/M4YqpSSJU3EjVoLgo5U7rTJF6bes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWt5A+y5wXCEdk232QQNShQnqjW4SbplONTfi4BBsNBOwcg5MqsC0nARkNRtOTV7vBOy+Sp7ByuJDuJvA9TGCcQgLF3lUsYK2SVKq9C1exieuvxoc+9Z7EXYgw4UdvNzNmZodYKaADKS9LFQyv3MPBJgVwuAUvfliM699hCVEhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moK8kURQ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moK8kURQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4626fdc829aso107379f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782421404; cv=none;
        d=google.com; s=arc-20260327;
        b=qd2Dj1swqYugqhZ3EnsF0Rsy/G1QsNcTaRK8KjZliv2kn2EdmoEuTl6RQBldZ1QrG0
         MlPD+mcp5bYMR8vOdHuK/T3e/VWqxhguGt4UVQoNeFnugFVdAobYbDFl3cAUsV7580vL
         siHlonntztArryor9bsm/M62PrEdncd84rwQfEAU4l98qz6VA1F6MN5O0qbKO2LiqPTl
         k0TcO27nZJJ+W6XOeh3kF7K2Ovn6Y335jfH9rtv+F8/JL3WzZQRuG/2iyCrWFJdNrsp/
         3+5OUL0+0q8m21cnNQf4r4axT7CrxXM6RiOsSIVneDr5oBa1QsnO4BYoWIjuWCyPcMcl
         NE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVg/lYpYcOxnqWcUc1KZUrD79iR8xox/AhH3koJoPkU=;
        fh=W8O97pdgEGD+MaW+I1zASkbkzXp0OXo85qLi1/EbnME=;
        b=T1EQetH2HztS8cpv9kWmvZs7LvPb0UBKqjl1azhSFq0Dyk/Uk1hW+Z7Ku/SBOscL5n
         hVgNsJTPY6sEBrOAMqt4fMH9vvHfHLzFLtUGBpSilzL7Kx8N2sWx7BrRLTI0ONVFtsit
         YM+SOdUtBMMKqfZK7LCbIY2AU5O8Vsaecd4EBs/PX3KzhReQdCyfFXpozv+wyoudcW/P
         gGgv6CXXT29gBp08Svjqf1mwClKDoQkXT5YKs7nVd1dmcN55t9rKGzOEL1pQ8S68zD0Z
         tjhF3LwlR1m/GFSUtOtvfD+Cb5o74Z/1f3T29TW2bl7pS3QulPXEIL835N0E0TcvkMxS
         MxEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782421404; x=1783026204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVg/lYpYcOxnqWcUc1KZUrD79iR8xox/AhH3koJoPkU=;
        b=moK8kURQXdXgtGGZr0Ut1RdqRcn4jih3GAZAp3KIp63yJZ07+X5a69jbvG6or1Su8e
         sUD7zBi54artSRM13BcZ0kZFYx+MrpMVJmonMTqXDTjgHKrqbtEm9bDnAEoVLg5wtoJD
         jN7XQOtSBnFjvbY4vgOAzK1vqmSBYhukVMaRFPcunwqWPFIXhxqF2r498B1FZnW+Ef9t
         5v0H6nZl6BNDfFzVvDkhUfuKS9f4dn1ykvC5MACtl3kw87krqEY8j44FmF3sgLFyL5ws
         18LHzIsAbSkKeQuN4LyLGsS96WvTOGplaNHmp9HK3H89kUG8AXCceOhKz7v0TiYj8z+x
         EmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782421404; x=1783026204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVg/lYpYcOxnqWcUc1KZUrD79iR8xox/AhH3koJoPkU=;
        b=PvsecCC8k4KMDTW1dPybKHTop0Ma6rmEoFejF2mvcGSxrNQTKRBTx1JrbLeHp2KmfT
         tLeer7i5P6Y+Bi6Jf5HhpMyBfIFMQGtOvs/i+RCe+u+kjx8ij/rPWI6sW+NcQ4tpoxha
         8xz2qnPn1xJNwk2+WezudsV6iXEK1o1vg4A2HlC0EemC4IK95PKACVzdMCrqTI4aPjlV
         DaipNto2nglgIWj1D9cGoj8VF73XmzacrBY2PKOcro89VR9MEslVFuqK7eIjGNXxqNAL
         IuYwD3VVSzbPUWdZZrEj2gJtpp+NKlPqOm4fRgye8Ch3MFdh7EwTr52cqXy+GDlDCwM5
         9HcA==
X-Forwarded-Encrypted: i=1; AHgh+RqCWtK+KLoK0BhnpZDctRCSk0VldYP1O48vsEuxW4VF/3znbJynSHYJZO0yJ+pyZ9IhTT+r7VDESRyKHsrm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EvDP3L054y40tCNFsEDPK7lSWeg47yqtNhorcjyAhjySl5Th
	wRV1zxiqFQMLHlZoAMrdmfrFABkprt+eBeTSTBGWVlAaCH1YmjFnFiQaOEDG/JR0oGLK+jpHebg
	aPYS7NITi3pzeQLRJBFHVuT3+iRgciSw=
X-Gm-Gg: AfdE7ckCOmSsHqUwYHFzuOpXwljO8XxpCPXU6dkJ7NWf8liphI2I5aSsBnJ0eQb05oS
	/bK0hWhy2CmuISfIJBFHaD3LZo1I61fzBYX5q3FRka9ZHroos9X60IZjm+9Z3S4AiiipaBgKq/f
	DZlBN1Y0Ntput/omumMkdzKGCAmCeFq5B1YPxCCoXVK5EtkBgCbqWyYLKOAgbwAymn/hOy8YzKh
	Or9QcuW+6BV2foDRG+e2PCJ8K52w9b04uu5+kuWYVNEkuFqERI7H6OONWxmTAz4iUPnenMHJYgz
	dzH1P2iFYm/QZ0jNJ9ERkN66D9uqhEZZASA3NHs0E7DGFoaR/YOd
X-Received: by 2002:a05:6000:2884:b0:46c:8f47:3b5a with SMTP id
 ffacd0b85a97d-46dc20764e4mr6647539f8f.23.1782421404613; Thu, 25 Jun 2026
 14:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625024723.1611000-1-joannelkoong@gmail.com>
 <20260625024723.1611000-2-joannelkoong@gmail.com> <20260625125656.GA22620@lst.de>
In-Reply-To: <20260625125656.GA22620@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 14:03:13 -0700
X-Gm-Features: AVVi8CfUb1ewUa5iwyynGN-pNOt-tT5BQjLMm4XbQDUjecT5437YaC673hlN6Do
Message-ID: <CAJnrk1a3dY9r=jGVyTLT0k-J11wrdFc4sM6P94FBKwpi5TQTNw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] iomap: add ->iomap_next() and iomap_process() helper
To: Christoph Hellwig <hch@lst.de>
Cc: willy@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 5:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +     /*
> > +      * Produce the next mapping (finishing the previous one if needed=
).
> > +      * Return 1 to continue iterating, 0 if the range is fully consum=
ed,
> > +      * or a negative error on failure.
> > +      */
> > +     int (*iomap_next)(const struct iomap_iter *iter, struct iomap *io=
map,
> > +                     struct iomap *srcmap);
>
> If you add function typedefs for all the other two methods I'd one one he=
re
> as well for consistency.  We'll need it anywone once the legacy ops are
> entirely gone we can kill of the ops and just pass this function pointer.

Sounds good, I'll do this in v2.

>
> As for the arguments:  I don't really see much of a point in passing
> the iomap/scrmap separately vs just the iter.  Or am I missing something
> here?

It was meant to safeguard against a callback modifying iomap-internal
non-mapping fields (iter->pos/len/status/iter_start_pos) but maybe
this is unnecessary. I'll drop the 2 args and make it non-const.

Thanks,
Joanne
