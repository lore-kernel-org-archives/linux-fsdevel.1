Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DD3793C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707836; cv=pass; b=iYzimiDLvc3vHjOHR4g3mAP1huW0IsFABAKvplIqf6+Li0h/tch7FEpbaxDE62FalIGDJROtsHNgSuXudbFDBNpw76AofXNAyfjlV5uzY6rxzNzAcsrNpcyQ91dl5S2ChGqNdqpBiaur/jSPDcoIn16wPpg5CJbe1e7U+KHtmkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707836; c=relaxed/simple;
	bh=NxfR+RtpV98Uyvh4Vv0TesUuCBi39GQnAHBSA0RW5do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mr4oHTb2KGfF1U/PWKyRfCV+K0ZVcV4kg5tzuAO32foZcLLED2ssznZh6nhFUUcH+ps5wX0qHyh7NJgPgdN7GoXYWKhhuMrkO7KrSW699ZHM3LT4wtALh1hk7ulOHfG8nk7y1inE9JPAstqcb+9aG1sgv6fWMI1MSXwhj+oykWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jzunzhlv; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jzunzhlv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0c45c580so8423731cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 11:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783707832; cv=none;
        d=google.com; s=arc-20260327;
        b=dDPSNwVc9zFfmpRgK8qltNWVZlTgpPNtWM1N34leOvcEHkYe4JX+Iv9x0U2zskdgLt
         ZuF1dChECUUwQ4+A70aPhLxnyHTULYX7lmTAZI8E1wyyDqwQ69rsc95OHk17bTHoRUOI
         l7PPwj7FV2uL7UhR3DOloOgM2coRtYiPAoEzVMNVF+vl8G624CSWgG6ac0K6juZOGb3t
         0IDHKn+csYhe6z3pYy0d9vgHDAYLCfI5p0YeuOgFfh2xmvnWEV36mzDVy4kZUm58oD/q
         oIepZ02fP+ikV6i95GGvxepIFAKEz2+6oSgHYdCCwljqUp7Vjq07An+rgYadx8dLHpz8
         lE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1S5jxvfvOLQgAIm7INh0Q2705ObnY2r648KNCWkCwDU=;
        fh=23Qzh0zJoRwlrOL/hu9KbMcE4vYWR8UCim1pfwp1uAQ=;
        b=jDh3ht7nfcBm9sq8L/O4GrYGWgbiaw9IKipAMwgZMicBSe94y5e8ZdUHSDR+CrdjYq
         +0YiugaK0R/YL6tdleYGSXbuHkjfW8O2PmZ7EpAK2seKTC/W/gjbbgW1pj2mptnk/rVy
         6rx+PhgQX7VZ/DySNhVUWOBsE2x5K4worVGIMITLtnEhG5QZnuZezFuubhAjDur0G0vL
         6gpi7uCQ/7Q1r3+xvGYxyHG6VBuRB/cxrme4axtU+ODbZcTT6P/lHxx+R4HmNkVvPKdf
         akI3cqRRQLKgl/vXQpsd7ofKhU7gnYMcM4GMa9U9uc+TsNUYWGRPl4jrRmpniuhqUjjc
         96eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783707832; x=1784312632; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1S5jxvfvOLQgAIm7INh0Q2705ObnY2r648KNCWkCwDU=;
        b=jzunzhlvhlauPfXky5Vl0XPvVolaBKFTOI+oS3/Ejz/Vo7GucK4CmuCXLzU9sjaaMR
         Uzds8vpJ3Hz9FmrKU8I3CjME5irVHg9jCs5bu87TWQ29lrdNCfqsigs/bjRY0PyspUKv
         U1oBuVdh9Qpl2aVfP12b2/yBFVQYEpdPE/FXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707832; x=1784312632;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1S5jxvfvOLQgAIm7INh0Q2705ObnY2r648KNCWkCwDU=;
        b=n1s/SeCiM9i/dt+bAwxCwmInUzYGWZ6TRq77X7S1ekD3gWmjOpwVJjqP4rh2X43yTY
         ViYt5/XDurADZnkc+ClYBkfZXPrzP1c5iqe12vtVDZzdafLhdCJibOXS3Sw9h7G9rDVF
         RC9s1akQSltWEYkS4vPcCfNU8CBlsKu3xrOfdn9l2/suYPDorWwsaEjKPybwOpZLB1OZ
         kVvleDPXtMhiSQvk+6xPa4P8iwB6PASfNaO+dQa1DdEFdqJ08x5xdDsvW9RmhGQyn6au
         eF3ZmSpjz8KdgSdpia9VwERH9+N5/Tjwk84aoX6z5Zw1Dk33XG2lmER7+ybPq1xfxCZ5
         Iprw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3T2Lz3WEWAx0EJP7LbDZREx+1mrW1FO1UwxFMHr1rmh2QxYp0fvHTCLUAXWCdxvCBgQp7OxrDgPPCvgpk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SUTlyrUkqGApR8Xrxgc8UOildlp/hcep0HOoNioQ/+OX1l5Q
	w/07DzjUs3V8eWD9PJNrJgia8NxHRThjmfv9PIdthFPwHu6Pc+ckJkeJ891F2U+IZ4d8rpC13+y
	YO47z45L4TNwGj0B9Lw2N2KTqzW4TpuxukKo8CPbUxTZOARhNcDezK5U=
X-Gm-Gg: AfdE7cmU6AY1qAHHVCXN5mbtH3NBf7RZdNB07NLUBX40zA3yZMgQv4JKkHoo1sBwy38
	M74WnVd9fZvWuHfQ90q9Y1ascWLT9+GYi3UDUkrbtZwewdGXSt6dc95E5AF4Qp2LfcuSrWymjQj
	tf6ibaDOBEv6RHJGFaQsgrVgrdzdjHd2ot4bn9Upx2auWrsd0uOyw8VZb2k17y3QPthgOBPqudy
	2lhIgyG/s5/T9k8bwBIhG/GUFkUOK0revzMm3sYr5SrYqSajckbLQ+CLoBTlLS6les/tnXbhn52
	GdXNYSgNyFRFMIAfbrRtll9pAcumCKfMDuv0Jw==
X-Received: by 2002:a05:622a:5a05:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-51cbf15ff18mr692361cf.27.1783707832090; Fri, 10 Jul 2026
 11:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com> <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
 <CAOQ4uxgZuJ+=RQDh3577H7PFAfYyF=wRJ55aPuuUW814Htrmbw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgZuJ+=RQDh3577H7PFAfYyF=wRJ55aPuuUW814Htrmbw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 Jul 2026 20:23:41 +0200
X-Gm-Features: AVVi8CcKiWkm6xoKpO6GLoDQetvLN0tImMPwxwYtq4HkU1puSjal02fIPnnUZPc
Message-ID: <CAJfpegvGnr2a3u9qTEVgZyUpeYF0FoRg8xzyGg1wfw88Os5rMw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Amir Goldstein <amir73il@gmail.com>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 16:32, Amir Goldstein <amir73il@gmail.com> wrote:

> Ack for this, but please don't use mount/options/... it's a bit ugly
> because most mount options are not opan-able.

True, but I was thinking of doing this as a reverse fsconfig() thing.

> Please stick to something logical like "fs/layers/N" corresponding to
> ovl_fs::layers, where layer 0 is reserved for upper.
> We could also support opening by aliases fs/layers/upper->0 etc,
> but no rush IMO.

Layer numbering has been internal to overlayfs to date.  I'd prefer to
keep the layer enumeration that is external, which is the mount option
interface.  Works for EROFS as well.

> What I am contemplating is whether we should implement
> introspection of the ovl_entry stack for merge dirs in addition or instead
> introspection of fs/layers.

Interesting.

> IIRC, the root dir stack does NOT hold references to lowerdata dirs,
> so support for "fs/layers/N" is still needed.

So let's just stick with the per-superblock layering for now, which is
reflected in the mount options.

>
> For directories we could implement "real/0..N" with aliases
> real/upper->0 real/origin->1.
>
> For a regular file we could have constant aliases real/upper->0
> real/lower->1 real/lowerdata->2 and/or dynamic aliases
> real/data->{0,1,2}, real/metadata->{0,1}, real/origin->{0,1}.
>
> Those could be used to implement "revert to origin".
> Specifically, I think Daan asked for it during the last LSFMM.
> Although I don't think we currently store the original lowerdata
> in ovl_entry when lookup is done post data copy up.

I'm trying to focus on the "return an O_PATH descriptor for stacked
layers" for now.  It avoids having to deal with opening files or
directories within the O_ALT namespace, since magic symlink following
is used.

Thanks,
Miklos
