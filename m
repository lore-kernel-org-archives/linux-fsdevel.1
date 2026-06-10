Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA9406812
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093856; cv=pass; b=khdNu6XYRYivb13Uia+QEb5Gt2bk3PxS0noSY5MkeajzEVRHFYrS56isDP8EahC5aS85nf8aO7Ox/twCGBohtTiYJkT8zDlg0N1T5Mhp8bWEb44lUlDONuIkZA8BUXrp1Gi6xWAicEX63eCaWOi1t3BlLF+8eb241RJvqI7RXlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093856; c=relaxed/simple;
	bh=5RXa72RxiBocK8wJRrHBfb5aY4Pa1btrGqfifqrfK8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvoFcyxgb0LwXQj44F5IhFy/z0zPoMUWfK6ZDklwEwPYCHQgJsagVV9Y65528JV/ZHRylq76xPoMtENdkKyUXKbEu4YiPNIt/kQQ/ILsZeXn5vDFsFiPaB8JIHB3LauEU6gsdSl6vwfCNU5/BfanYbvCih/KFwXBQtnGCl/EjfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Sb8tvjLr; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Sb8tvjLr"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5174a3a025aso67488401cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 05:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781093854; cv=none;
        d=google.com; s=arc-20240605;
        b=OrZVHw0QvF6HxYg2lsUoCjRMO066gj+7+kzokET/mS855fgcnUxvknY/uJMswwLhap
         rpxmmSpz06YTdNogilgIYDIVgCXqUkp1uS5CNhSnGVRaADQUHH4XekDOCpn1W8pKtbz5
         /A69M1GDMx1DUzLNtYj1VdAz/ht2kNeJiUS8OJF2mO3Bx6/Om4lBbp77d4ZKEFg10SJm
         vKsL8ldPXGKX9V/v+hHyGwR3b0+7z+yeNmpnwVXgvGUBk2KTsHx/BLXyK0PvpA8D9MzB
         4MxRq4Zvjwh3hQha2xkefkRtdmE2Ypo4UUoQhqjJ4ouU9bap+K0G5gzeY+ry8oKmbEXm
         MAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TT7vUxed9V2k0b9o6+nhZGw5j5GO8hrCvm+8/mVl/es=;
        fh=PGI8exPzzZ73V/kd/UXzVCsMo6O1U8IQAkIW2/r8SG0=;
        b=XGj6U+IzThku9sQCjWKgo1r3kwJAuAeBYIK1uwbC7UqQJWYLjTdwWHE2fDobjKETnW
         8sHUXMWlWP0qeh27fUXanMG2DtU2Sl+J5bTmnPcSQASVE79gL24/UnM3jGI0mYRvMPM+
         NoKSvmjLwrao8TBmSptaHcFIr33bB+ABWw+Dn9d4DW/OQcf1b2Cs6WwVWFV1skjhW4OB
         zGnH+j+1Z0Dm3Wml5K79HTrMhjfWGKstQ1MaqpikMomVy/t/ToxEWPiMFeC0wzvv8Xzv
         StGOOKkBI9THoXkikrg7ZZqcUIW8f8TTmJKSerAn1Aw6mhk46FRg4jJnrE4/hD4ouRBx
         ygaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781093854; x=1781698654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TT7vUxed9V2k0b9o6+nhZGw5j5GO8hrCvm+8/mVl/es=;
        b=Sb8tvjLrbRI3WamlD0SYTFf3PBvcC8X5UNC7FjiVVLuibysQGpgGunFjcej1L/A2BZ
         LDFWHRNpZ/b0AvpKHbmvuG12Tw7dFoORp2Ykn4pqqlEm0q0UWbbazaR9h2rzEDbfPtDP
         dtlQAADFtql6J0uZphHJqGvFWPisvvjMynnFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093854; x=1781698654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT7vUxed9V2k0b9o6+nhZGw5j5GO8hrCvm+8/mVl/es=;
        b=I/YBFFVtq0HYvwBfvZnhb9aN+Lcdf/fnkW2wIjFmkNpgnLDSS8EXRwEjLh01k42V1a
         XYAU0MKyE/i4uBQklxP8+VIgjkyRrusCNVSBdV+K2RfDt4q6wVdf/qepZsVRNOdrm1VI
         w05rfKKHbYHXqaeVvm7ZDDjkggMr5nlGtzlEoE0jri78S+mb9AXoQYXqBg6GJ+aVsae6
         3VD5ML3t+pe7cK5yT508/zNovbwN1L6fFWSL1tvDkdThqrklGtXNrGYfnAp3Q9J5fi1u
         2BYN9bqFy+k1sxZQrtLZ+wVj3jV1G76prsSkTe2FQ8E8uUaP16H7HCxnj6GtqN/HxVIN
         mtYA==
X-Forwarded-Encrypted: i=1; AFNElJ/UKCRKheo2xTa6pIz/JFlTIMHnFOWucyJpureRSNv0Q9lryHtk8rVNOQmH64AJiTa76CVzF0UTMN5nXOPr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/d5w44hTGe4YTz5h7lBNAH0YlOrCkfLGoKPvQmmIvDl4vfgXG
	efOW57klE6ZZbhg8HUmq3J+pYFpKUugq6x02KaMUKC8Qnoy62lz71WrYb4JV3KigezQZq5XCqYO
	n5W08SvurIOUzFbffaFOzP9xNnujT1hqB+1IudHl2Pw==
X-Gm-Gg: Acq92OEXwxuh28txeNZV9AZ0rhJP1z0X7fwt1U7IeQArYAiH/imH6707MlIgEMX1nzv
	pPVYARZvxDm4Lj3/BJ8SVDh7pSRy89khW2bpXQVnS5T4hgmcYID9MNhfs+Fl+QrRN15hliHkT4y
	PoAmRdCsaC5WvJTcI84AxN3hodACeEQTwWiOf0wxist6l6YVebVygrTOVJJEbiBGJ6D5lHl3/LM
	5MHruE+t5ri/GydTmg0s3rfLPqW0UsV9Zr4y80JGSXcd8cO07o0/BdafqrLITpW8PiDrVYWrhwq
	LCudUOY9qU30sI5yL+h8xOFUshyJbB/uuar9iRgYqRBrQy+WRIE=
X-Received: by 2002:a05:622a:4cd:b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-51795a7f3dcmr377491571cf.4.1781093853738; Wed, 10 Jun 2026
 05:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508134541.282073-1-marco.crivellari@suse.com> <20260508134541.282073-6-marco.crivellari@suse.com>
In-Reply-To: <20260508134541.282073-6-marco.crivellari@suse.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 14:17:22 +0200
X-Gm-Features: AVVi8CdDxJ1TB7_ws3sir1l7bjNCID03QC-QtEthN1DCePRXj6LQP6MsvdjlX9s
Message-ID: <CAJfpegvW1yoVEfzbArHye4KmDgOuqeVHNhahR6Q25cvB-hHfmw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] fuse: dax: Move long delayed work on system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 May 2026 at 15:45, Marco Crivellari <marco.crivellari@suse.com> wrote:
>
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
>
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
>
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied, thanks.

Miklos
