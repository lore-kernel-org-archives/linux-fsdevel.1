Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE929ACD7
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169000; cv=pass; b=DRuRZudbFDorPaYrSwaQ9pbL4O4xby3pYdOgMChS5uAUm5YgoB/a2Usuf+sLux4OXusxn7YS8F+iQ4xN6RokpeuxcuVMjVLTacDGh1u+M8F4AOzlW9lT1tFonT0XnkIiF3pkhkoLKX+higi3zTq5BihlIfAxJ/pJgxa9OW3Ll8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169000; c=relaxed/simple;
	bh=cM5Qfgu26HeWPnOS+BMs/06uKacZ3LRecy3MhffiVEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSzDU/zj7X1pDILKuZxpnvHoWgalZHbtr0doLQk+zzbfRtZdkbVIfxiGGYTi0B4q6IaHz6d9lfNTYBnKC73v0vokMmCy9tqbYK2+d//LW2DwImCkwV5HVXeCTmR3Cfzck5NvwebQKJis45jIaCeRTbmKPZh04F6q0y/DPrwyXZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S01gbA1J; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S01gbA1J"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d876329bbso8817711cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 08:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168996; cv=none;
        d=google.com; s=arc-20240605;
        b=iqKwMWyj0FM6JMILy3J8wrlWlKe8e/NNvgFzE1hDFPvLlVbdn18bKKmbFtszz4Z6Cl
         3d+j7EGPasNe8bMLZXJvGhl3XBW3mTM3YlGajzXzq9w5czq3fqmtI1sYdp36aElDjL7J
         J1bQwxg2iXoloLXxtSogpOpFgrG/brjSVLR/j+9K8cEB+TFGIYyIKt40gng9wO1fcX8q
         E5aEjmO/BbOyQSbk1X2x3zT4ss39fZ5lXQB3lYOxBdVl/213ZbEzcFpD0/FW2hovnt99
         z8h8nIHxBs99NHgBjfNiQKuMUvDMUD89BdaopFYKJHps55onYfoS1L/erEG0romCctJK
         o2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YCLGNrMDke+UiwoXvwXPE7/456l4MP8QDj44lzoYnFk=;
        fh=qxZ7rbP3qJDXJpwWf0ZU+eyqEMYXpWDFQTy3MLeGuQ4=;
        b=XgxTzOZjLsM9qn3teK0NnG7NWxyzg3j/8AyWuV6mg8Avbf7zNr69f7JB0VMbHdsDLO
         zaZBgKEy4tPdj4yI1u7wJQK4y/8kcCcUOlvMcKiIGAQEMuf2+j/IoIFQC/aRPwDCWHR7
         DuDpeos/1cwPzyBYD2Fouei3oupMcPK0G9ssyG1Dnngmi8PaPuTi+V9KGk/JCKIb5HqC
         ncQR9Whr8AK30LjnolD8yh2IeZslC8Ks/nIO//03osr9stEAoJaV/MOnDzyY4eeL/jgT
         9k3u7UgjoK0N0fS6OysrNLJjmEypNqyA5y5J7jH0RaeQFLUADXwY87LPXksbfncc8cxz
         3RnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778168996; x=1778773796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCLGNrMDke+UiwoXvwXPE7/456l4MP8QDj44lzoYnFk=;
        b=S01gbA1JrSBjv4qgRTbMB1PAXblylTAliQy/4h9OFKIhOVinv3oain5FpPt/xkyfC5
         V86lvoNNwZbsTO3d91v6GjILfOC2cVC7UrOugy/CUYyCbtOiDip8pA7YPfXpaZ71fU2A
         r+UCv4oni/eoYcqqYokpaKEryBPgW5WXiT5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168996; x=1778773796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCLGNrMDke+UiwoXvwXPE7/456l4MP8QDj44lzoYnFk=;
        b=foWS35WqnfogC6Pfghdnk3RgPcZGzqXBTS+9otaMUx5GpNykQgnurzMlf8FVsWRTVh
         EOuobW03/YHOriNoFZSSx9rOQA4xb/fh1/cA1ODdRLSsL0KT0kE/3TB4dY+zzlO2NEFd
         dzehdR84LO3GLRDywDR2kM3RqpQFzYYLm0qNfFR6QEnuL+r1Zs02neSRpRqDoSQtiu+T
         ZrKC6zVRtJXF0PFNYFJgpeJrn9xeNeYmBzY9t6BuxgxY/4Lwh7Khjlf3qN79hXftwFhf
         2gLmX2SR9YulJ8FMDMtIZZAzzmo4Oicp9Tq3Ws2HrdL8Ljt4f1diMTzttV4Gghi0hf5c
         rYQw==
X-Gm-Message-State: AOJu0Yxv9FaBYVkFngFFk2zzNSfc3SwFIjgB85iZNqc3zMrgPUsofzXH
	C/UaiILNDQxNal0TfKEBRnOLb9kXNxjwMG0QvPr2rOyOPp1H9eITSRS4Fxec+SG8neYvAqg8CeV
	iuAKS6J1SVf6JJ+QspAAINEKpQqRl1y4butIpNNA4tA==
X-Gm-Gg: AeBDieuVOLkfr+iWVrG70hPw4oG7iPRDILyE9ZG18UfJPMtWoLGs7m2W600Gzi4AiDj
	jOYtFlCTPsgYvAfeU2XN9nYotdQzO+waC0jlBvzWRv+mk+L/uId/w6DOvE2HMjIu1GF/XWtnuXW
	ACQGR2Iw/ZMNS7LyWhva1Fxm9b+07Ra+npKynYBBFzhh1rFCarq5rfu5eRZyZNVjkCwPm5lttUD
	yIUShwf/mi3O1GvTjnABuQCNjw9ym+TVQiGA+droQqi/bzskirXgQ/2bP+hnFwJIq/od0RpB87s
	ai/7XCf0JPGSVG7drkoaI/RZhPeIUw68Bb+IIyI1
X-Received: by 2002:a05:622a:48:b0:50e:a1aa:2cd9 with SMTP id
 d75a77b69052e-51461c04ebbmr112852541cf.15.1778168996266; Thu, 07 May 2026
 08:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506122415.205340-1-qjx1298677004@gmail.com>
In-Reply-To: <20260506122415.205340-1-qjx1298677004@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 May 2026 17:49:45 +0200
X-Gm-Features: AVHnY4ITO-Rvtl8Hpuf2meRqmUsBlE7Te--h2ufYP7Y3hMpAgIZjOOspXr3r1gU
Message-ID: <CAJfpegvBgjaT4ZhWV8dm-5AKVKpm2N77gu1+nJuTFSLVyXnCwg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix writeback array overflow when max_pages is one
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Junxi Qian <qjx1298677004@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 14:24, Junxi Qian <qjx1298677004@gmail.com> wrote:
>
> fuse_iomap_writeback_range() appends one folio pointer and one
> fuse_folio_desc for every dirty range that is merged into the current
> writeback request.  The merge decision checks the byte budget against
> fc->max_pages and fc->max_write, but it does not check whether the folio
> and descriptor arrays still have another free slot.
>
> This is not sufficient for fuseblk, where the filesystem block size can
> be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
> negotiated as one, contiguous sub-page dirty ranges can fit within the
> byte budget while spanning more than one folio.  The next append can then
> write past the one-slot folios and descs arrays.
>
> Split the request when the number of already attached folios has reached
> fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
> with the send decision.
>
> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please apply this?

Thanks,
Miklos
