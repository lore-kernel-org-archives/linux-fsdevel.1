Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377994A99D9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440862; cv=pass; b=UEQwfq0cRSA6yL33QdSrVtr+y3afC+Dxq6ow2PAV7zZsJQy9IqqXiDef9KZdm0hTmrIR1IPWYhNq5c6GfX+Jcsp+kIZfxBz9qioA5YIo/fphJ7ejWIJxBQ4w3PkArmTFc+oDc2MkPCgkkE4b5lZGeyucde8b89jj8VJP4+fQpts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440862; c=relaxed/simple;
	bh=Nd8rHpqZkzQnKuba89VN+LJt6o8911mVett5MRHbbrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWzT6VOWBpQBQVLbQFaiO+2iOMKMr0dogSDPnEpjpcOfFo2p5re5Qyz/ffKA9LQe7hHg4Xi4X6y5mZkCC5+68UkyLcOts7BiD5ZBQ4xM7/YUPUsTlwx6hYYBiKgSEBg0PqBXu58i4uPzbkLejam7yfZIz+Ba4IcMe0cMhzz1U8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa/xRcBZ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa/xRcBZ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a68aaf4840so2410754a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 06:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788440846; cv=none;
        d=google.com; s=arc-20260327;
        b=jeD3ja1FLoz+jhRmZtPEI6fonnXchqasABrHcxYgBWF+P7Ruog9vxNvyZ482tqRz1C
         rZ7xiJi6/a9VdBckqf+WGDRJynBg8L9ChJ+ShXbLmQUJ+xC3KBi0apERI3E5WonrR0RQ
         C0RAd7wAiIptK9AX9hn+scdJqHDNWUrVWwpA+paa8nyABjTqtJxqj0O2mvyB2o77y7pn
         Y4ecQ3A9qopRpdPicccuEjOBWoJPN0Swc8humzcErbMnrfjIeexV+zUUsX0LJBqkxtg/
         5UDbU1LuzkHAwD53ZfXieLni9bhxNR2w954Bbo6LefYXeUnLkiScAgfI53vHMcVrOR/o
         xNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUp+GFf63QjLB7Up5vOnqaAVN0sMzMPtRL1Aa1NBkZU=;
        fh=ZTf7EOrQSvgcD5qU5EYmbZUR9B9Dj7xcBP0ymASyQyM=;
        b=hBGXCKh9Vx8eymqoExjYpoW6SOf4sJR9lniMZdzncfwJ1wx4uJoV7vN1t8pkegJf4G
         e+i774gCKuAvg4huwnf7SuCrDBcKG2ThB0dB42x1Gz+rU+7URxZFdifT7/OgtnDwgsbG
         BUXOp9felL6mqOKRjKQqF3uBD5gelIds36fVdV2cjGWo8tYU7j3YUFZ4TUXkBkBE1NvT
         VGDjRe58wnp7TYM2eoU9tGShVT6+h1aC2bpSLUXWawe+U7sUH3+nw25NOQg9La3/2guz
         4w73OFqtk9Gbc0tgAzQDSTJ6m5kDfmLcWzNcKNNMy4tCuItY4I5s/5Eo79ZJQkxsCTJP
         ne4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440846; x=1789045646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EUp+GFf63QjLB7Up5vOnqaAVN0sMzMPtRL1Aa1NBkZU=;
        b=Qa/xRcBZADon0kzqw3wwVTKLqfbXrgiDedpIXkLzRysLyhW8yjnLh5hGFxPj+fHxkO
         pMOccC/t5RTOzmXJCabUR1HA4ICzuIEONHsMkm3tfcrRoN4IOlLI3u7naIdGcQeICm/9
         H+h4BIyNHc+B9zsQeajNVaVgEtS7EAhGOQJatPF62gJ4OLWXBBtJ5fSlRUXfihE8daiV
         KfC0sYN01gFPqa0plblAIXvkFNREEeWX6y4akPDlMXTpZ2fUKvCWQR+TjY8Qd7i1xLR0
         +NUnaykzc4N3ndqO2qd174aekOiHRMTrz6NkgzEAyuAwQW6UTu2cmlt/3r/3nu+zwkT6
         yIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440846; x=1789045646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUp+GFf63QjLB7Up5vOnqaAVN0sMzMPtRL1Aa1NBkZU=;
        b=aclinJqRTBqP27QyIT2jVuK+24EGvFDNgSAx+1IIlmtBIoEV9bzajJ19rqPevRi0Nw
         g+ZyZnO1Q1/icIeasAar2f0i0K62hs5ow7jalx0W+usrb+0RSw4N8eQPEpQYGU1NRzJ6
         FtGyCamGI/p2znxb5EJrsSOrutGV/38xkI921bE+7XM4ctZtLqrdU4x0DqVqvS2opizq
         djFBrh1afS4gM+6CgqOLf0bmUpOmHDeBwTRB4vtMDdxhpCnVZKmaLIex7+ugLkPy0/RZ
         ltKpk7yqQWrDbwiCHlVtAn8pezfQB4Wwm1T1uRHvrzwu9lU0daUCeMAAOVuUVSA/fDFP
         o7cg==
X-Forwarded-Encrypted: i=1; AKwUvBzcC+JAtYeoRL+bsL9fkXA/ln6740T8TJIciu8JvXEzAXW75IXDvkwlHT+67cgoBGU/nJSNhSStKLBNTWcn@vger.kernel.org
X-Gm-Message-State: AFuF++nlz2JR2pYWDSNi+DtDpSqsh2dMxRrLyi9SC5SAgrb+fEe5f8cV
	vTHSjgB4Ol5LDDBV5kRsMy0WM/tj2/olPU0gsyzBJchSsfCIhhllzaosor0g6PfbxKuzZFZBQ5F
	mdquEfeLJItNxA9Apcq0BSJHB4VAApAQ=
X-Gm-Gg: AYBFou0m6lCzIwRbR6dhvOB6dPsCH4gsWsvikBhWIrpBTyLVlrDKSJWAS2o2RGYeJKE
	GhbCSWFF3GXjTt4v5yZCG96c6BDcgtsh2ZuT6PzYEH4A3nfyLYaRKT+nZ7EU1Eick/nRgV3+UYi
	PkZ6C/ybKrOr8Rk/Jryk2XpcaP2bykfNQhlnDWss3giZtJsOcPF0+0CQObFyQsWL5bg4l+CZjN7
	g0YPKsfSRMnYXfaPtAvByRnzSi9/CLIDI/gFPjqfPP9++f0Nmx7OZvdfKoW7+KxFjObiDg26NTD
	sOlIQaPmppOSk505987snxTbBZjxcc7X/xkeQSJMSYXCXJ2lX+sCeiCi8Q==
X-Received: by 2002:a05:6402:a246:20b0:69e:2ca5:53bb with SMTP id
 4fb4d7f45d1cf-6a6b343441bmr992277a12.0.1788440846228; Thu, 03 Sep 2026
 06:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
 <20260902070359.4163607-1-4ncienth@gmail.com> <CAOQ4uxjwGdKhX423KoFxW+T5hc9uzCWSsGwn0-QX=CJipPSaYQ@mail.gmail.com>
 <20260902215046.1149198-1-4ncienth@gmail.com>
In-Reply-To: <20260902215046.1149198-1-4ncienth@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Sep 2026 15:07:11 +0200
X-Gm-Features: AcwNN1WUjp1-QCHEtsLKZkQ5zIRcFzgXuNi7fdLVVvXP37pnci0cT-0jS81qlNg
Message-ID: <CAOQ4uxhuOSyMHnj9JZk6LU9=wpE=BRFXJ3fSEOGGV+6tC_5hfg@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:51=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> Hi Amir,
>
> I was able to make the handle-reopen sequence reliable on ext4 and drafte=
d
> an LTP test for it.
>
> The test keeps 120 auxiliary inode marks on the victim to widen the inter=
val
> after the first FAN_DELETE_SELF, pins the unlink and handle-reopen worker=
s to
> different CPUs, and has the reopen worker read the event queue nonblockin=
g
> before calling open_by_handle_at().
>
> I ran the exact final test for 100 iterations in each of two fresh 2-vCPU
> KASAN boots per kernel:
>
>   - unmodified v7.2: 200/200 iterations reopened the unlinked inode, and
>     closing the reopened fd generated a second FAN_DELETE_SELF;
>   - v7.2 with your patch: 200/200 iterations returned ESTALE from
>     open_by_handle_at(), with no duplicate FAN_DELETE_SELF.
>
> The test is based on LTP master commit
> 12724413534a6d4160ff9694ba6f09daa4ccb6bd. The attached patch adds
> fanotify26 and the corresponding build and runtest entries.

Very nice!

I think we should wait for Christian to pick up the fix or suggest an
alternative, but after that please post this test to LTP.

Thanks for following up on this!
Amir.
