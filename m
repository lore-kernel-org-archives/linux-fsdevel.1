Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD737649D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377963; cv=pass; b=bZjhzNQYDNmql9tK5RQk0M+PX2HnaWr2t3ObZF+LpaXn9o1gSvizRIYG0g59dURvISA0k8xsmBbKLhtebKa9E+Wrt8XgCrdFv6tlL2+tyr0//9yNBxiJYbltImEfQqoJ0Z+OxvuqhZF3d320F7befpQkfUDwDrPADz7fIrigjZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377963; c=relaxed/simple;
	bh=ayDPNFOFXpj+MdeVK53rLbaYH55hRDE9sJZFXFRNc5g=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5N9tcUZL0IvxlExCA9cTnpv4Ni1dOyjintGHqLPe0Xbvlm+aMjR9WTTAwLXNZ1REmQf/sHORfyaSD2NFkuDOQm8rIeZcKd7OAK0fMvKYi+HljJJrRJBwj8LnqJvAoIsFGvtCCgZPTNnp9aWzGciEz1c2CxrkVwblCFB8E9nsgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCrLogA2; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCrLogA2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7fe4808741eso23628297b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377961; cv=none;
        d=google.com; s=arc-20260327;
        b=Wh1rTzGdpsM9/CeCdjoAKHsLkgCpQc1XcTIrAJnvz+cYkCRfXcFnTBUSIir/vq6DNo
         X5jmtmQ96wLEc2Qb2ZttWa9WGPzBkHltTGbY9W5rEGEzcDVaqt1azOi6Eq3RTDqjlJXt
         Adp3xJPDxtDT69oiu6AN8EDzYUQ1HsRWDYwJxVO7I1mfuvIvRSg+/x/Fh7eUOzmERvoR
         zJuTIoyrjPBINwrOvsypY6KLKEqDvxJ97H5Bn+F9Wt7dyUFJ81Pz9DyQG4/fP8cE+iuj
         CepWvws1RRgkhKDV49FpFvbWZZRn0Pp5cb8C8GxMfpagy1zNXyZkDjNRDZeOqO1701Rd
         /4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=ayDPNFOFXpj+MdeVK53rLbaYH55hRDE9sJZFXFRNc5g=;
        fh=/L2Jycv/36vIoRb8SqUxZvk2OFqx9r23c5iu4UqIcK4=;
        b=Z423GvlCAljpsrMPDTYRggrFzVMlidl0tt8YRNquND/jL1JKuAlRjhEvq1R+SilJIL
         32IYplRZHTso6gDiELSrW3K+FW2uvwj60DYiy+sil9g6C7Humjx4aALNEdlL3pg45nvH
         Hskzqb1HnAYUni7W+P7i6Ri499GR8/9ZWsmJUyK50/zgO6iV1nPo4NAF427DIBt0zuKD
         ntEeW/KBG81wzgJKxFupYZdAzojItgqp6HRNBPA5VPJqIj82pL4Dy0/LdLzHGXzXWwVP
         DaE5PvteVJbRS2HXUqBb8+HS7Kdw887zl9BIaVPJ8aD/FuaBj+E7NHOMnkDvXrRgNrDN
         bAgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377961; x=1782982761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ayDPNFOFXpj+MdeVK53rLbaYH55hRDE9sJZFXFRNc5g=;
        b=qCrLogA2NRAWcNSo0c7TszS7YduuygZpCQsdJtOnLAKLD7j3lD+0uNRtRdfDxyQsnS
         1Sot4zvrV7pQsy0632dtF1CifShFQ28n+3Ms50jH2dVUqM+Q76N3/YqBcUmL6vePPWfN
         hVTWZySFP8s7nZeTLOEP02Cjx7bczoP9U3wvOVh0Jam4cnNfqqjoIMk3AAPy7rxOQszn
         k6vSqCOuuTWvv5kXR3x/wt2u/GbMgpiG19lgXwpdayQ5fOn2ZtQxbbb+yORtosvNDwkK
         WefqQyNHNiSiB+hP4ajY+zxwc9JVgpciIUSZc18sN2/8YY3XTLwX73GetzDifrv8UZTJ
         qxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377961; x=1782982761;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayDPNFOFXpj+MdeVK53rLbaYH55hRDE9sJZFXFRNc5g=;
        b=sddLqlitVGCZ4AmmWyYFRzDPXsaWsrrpD4iIB79RLhEfTu0DmxSN9JOT42/g7Coub9
         ECtKU7SHqaQZCWFR2ASQwc/SwZxgHw+F6nRRiW9wGxkQDdQ2/2HHrza0JHD7P6NkADbb
         JFMb3r6a/AZOFwydXPLFBXUBrpMw2dNrDTW+xWkStUS3BCK5jcqsqB4phOZbrt8F762I
         9LXfGYOhOULsRmC4NJbQsU+obebOUJCkggZDcsNIaVVOWeYHCrctYv+9XGEwdAtz1pj7
         l6aXF/f8PmEDr61GpMiuA1/0OKlR6thYjqHOShelEFESXejBkYy5ctMvK77taK7ADFGu
         VM3w==
X-Forwarded-Encrypted: i=1; AHgh+Rq5WjgXfQFewA0urHgvC3eX6/04DBLbxnKxIhVU1fOsRbKN2fBM6G4vf5TiIMnqJaNxTvu/Lshs4l4VYAHJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34ZY5ACDJXK7SJWD+ziakyqw3tEsFjGTikWkHAYcWG9tSVoSl
	buybw3NhFfc1qsIPtXo8w8zdPGoiHyOnv5n+s+CFP8D3aydE4hdZ5u3+S00vIxGz0IgqavUYFqH
	7GiLxgcRDCe07cYiiS27rpPaeIaATXRM=
X-Gm-Gg: AfdE7ckDYbWZZuzmLhGMF49piCQGROpYrWmhb6D+exSJFBlUi06gDjj5YLgRLnEIFfl
	/pVbgrS87biODqFbc64eVBnmF9HNpIrqK8Xf85nfLrQh+CcnvzPiFTtXw/z/2hCiW+y3gr/TuGo
	s9rX14tgVyxCWOHkkGoMaX1uqNxcHwF1fq26nOGJvMCiREjBs5CtRPm1qfh0kb6XadU9bfANX0C
	ZaWMi2rIuB3HNKP/caYs7cuhoeNLu/N15CO2l+rfGDJX/uwzsrwookfhdnz9iSwNOdeD2CGIg==
X-Received: by 2002:a05:690c:2704:b0:7ff:1d08:f0c with SMTP id
 00721157ae682-80a69ca0a0dmr15520557b3.8.1782377961489; Thu, 25 Jun 2026
 01:59:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 01:59:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 01:59:20 -0700
In-Reply-To: <20260625002752.96325-1-sj@kernel.org>
References: <20260625002752.96325-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 01:59:20 -0700
X-Gm-Features: AVVi8CeZVxZNreEFB2OgBmQNU7k2b8APFm4PSSOX7AkzrTqdOzpyInmyouNwIQs
Message-ID: <CAMuQ4bVEuQY1T=i2pFQCa4CwJHRVn7_PDTofB4nPMHdSU=KkFA@mail.gmail.com>
Subject: Re: [PATCH] tools/writeback: parse help before importing drgn
To: SeongJae Park <sj@kernel.org>
Cc: willy@infradead.org, jack@suse.cz, shikemeng@huaweicloud.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

You're right; the normal invocation path is through the drgn launcher,
so the no-drgn case I described is too narrow to justify the patch as
written.

Please drop this patch.

Thanks,
Yousef


On Wed, 24 Jun 2026 17:27:52 -0700, SeongJae Park <sj@kernel.org> wrote:
> On Wed, 24 Jun 2026 14:35:14 +0200 Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > wb_monitor.py imports drgn before argparse can handle "-h". That makes
> > help fail on systems where drgn is not installed, even though the script
> > does not need drgn to print usage text.
>
> But... How do you execute the drgn script on systems not having drgn? I tried
> to mimic the situation and reproduce the issue you are saying about, but what I
> get is like below:
>
> $ sudo mv /usr/bin/drgn /usr/bin/drgn.bak
> $ drgn tools/writeback/wb_monitor.py
> -bash: /usr/bin/drgn: No such file or directory
> $ python tools/writeback/wb_monitor.py
> Traceback (most recent call last):
> File "/home/lkhack/linux/tools/writeback/wb_monitor.py", line 44, in <module>
> bdi_list = prog['bdi_list']
> ^^^^
> NameError: name 'prog' is not defined
>
> Thanks,
> SJ
>
> [...]
