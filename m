Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F935B12B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016174; cv=pass; b=WxlToEFTc4+05vHwryONvt13Yu1aOKZUI5n64Xh0D6x4RzI/E+dYJBSsn26qOvakGqk2lmaIBsSyqA309/9YE2Dmn184ixqjDKix+ZMa53K8Vy6QyfRSBfSy5R0zP6U6nEtidNmf4e3UwG+w/InHi436lolt/MDPGqyNClUNevM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016174; c=relaxed/simple;
	bh=RrPczoppLc70P+GRUJ2NUkx8bjghsqN95KCjgxPqOfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU5HivRr2AmqU7T4DJAfNi/xaqP2rC7V4XYD8ncBhRAxDWTa5n1UESZmBSkRmWuZs029fFnmqKy8kdWirOlMgoIVRKMqV2LPuyw90KZegxhbx/87H8JSx1dogN5VXobUcTiiV504O6cnhwyvHoJ8xFuoMjAIUbHOjt4Bq1YBHlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VbbkD/3X; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VbbkD/3X"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5174a3a025aso57526061cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 07:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016172; cv=none;
        d=google.com; s=arc-20240605;
        b=gDaGMYlaammXwk6U5RScamUa3KGfZcFZ5U6mXFxCC26HyvU825kI9J9EtX+uOutMw8
         mdiTjS6D2KTG1+0duzVHPWS32SwnTDJ/Zn+4odzfRdyCtEor2EJBkaRfmaTTVCI1NwVF
         kyrlW/EH/PE0vVVertGrkoOF9IdAoqMc/gWnD2ER+UXReA3jczkWwukigQV83lgKh1cG
         M+H2nix6cANDhHaOwSbNIw2YJ+L2Q6DoL1jUQtsYNZGkJIPp2NsPh1gcZ9Lmn86kK4qv
         mwJGSC1IjOHKtSTWT5fQkBkFgZNIqfoMqcQglBR9h/3iZ/HLreHWHnnbgk+6Q7DA+5nZ
         fDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gz2jgnVgMVCedUm4IVCeuI+OmkVnycsyJMYR9iLQDgA=;
        fh=QAp+RCdy84LWnnvHdWZ8SHkRzkM2vB1sBPvnvsPxvsU=;
        b=QWNR7pdM6pKRvCPnp9Us26J9vfNGVV9RZO5XiVEIkALNDH1ZeH0SsjAWUT8tJciOxr
         gw4mGcc9fM8ruY2kkqhNA6STRMEkMEWYBh2G01duR2Z+fHTo8fwObYBg52uW3He18gC0
         ZSdjVSQCVKCkaBHI0hS9isjaZ0O1nG2rG/TsEd62eFeUNWskyTYWEsSODilDQkcOObks
         zAe/n0Gkg8Bek2iJJy6qO66kazlJOCH2VZSh4jgD9XGRHr7qrBNV2O5TXgMtwcgpnFvo
         LSRZAQfKlpeMhvZ7KwuyFlUSi5kW6BLRtFEyz31qm8nRRTPoPgHzunCFRka9hN2WDGxe
         wugw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781016172; x=1781620972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz2jgnVgMVCedUm4IVCeuI+OmkVnycsyJMYR9iLQDgA=;
        b=VbbkD/3XG2/x8+ErUX3rdgOjR/BEygHc5z7KMlALSOOqA+tytwcVLMHIkXclIpo4DP
         YxNWJHqjuKb1i4Sm+0auhX4QTPXeoX7XwOP0vRaMuAqtCwPMgrUFjf2hfNAkpnZfZIi4
         NBCKO10HtUTzBdWh/uVCly7Dy7pWyY6mIfDuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016172; x=1781620972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz2jgnVgMVCedUm4IVCeuI+OmkVnycsyJMYR9iLQDgA=;
        b=Q0uceL5ZtrHye3cQX93zuW8igRNbucBW4XrcrX95M8POSRBqSZ6X+IwO9B+wT6TKAV
         YbFtMTGB1y6ZwanNFSnr4b8zM9vNU0GoIC1WVOXOw263tyGgO3AznhpJEXGVneZYO+zb
         aCfwzXai6LOt7hwcIOcW0+70kJxFuFyrR7ViT2pyIwOAmPBqECLC6UWzQg+ssl4+I/Zk
         Kp0C2MrH3DbqPTPPPCZ8LtWrcN17Zqg7C0/gSHbpmKEPhi0VhIOIF1T1nw3rpR2kHO4H
         MmRLCx2/ubDXVev5ZxGrfmqxVYgtUSDjZcWFx6mWFpZfiI8nBRLIvydQYzPCVK2FMbg7
         kfPQ==
X-Gm-Message-State: AOJu0YwxGjq1yeKVj/aQMxp/qBuSLCSOXzVrsJM9oah35yp3etHH6zbH
	1kUvmMEWdRl0y6xkf5HGo1EnA8zV2+o84ZhfGEFOXW/K8pldgYU6yqwTcrmSWFQC+cjPXfUbkd4
	LGFliezsM4uScGAuX+Udm8Hqr8dTSNHpGqycjke1HC4jJOCIzdqBIEtw=
X-Gm-Gg: Acq92OHnWdcKnh9NQOXxLKD2liSTnyMl7UxhsdUBG7C5i9PGBEQrMq3W2Xg8d0prmmQ
	0sWBH6Bc5B82WwGG+HsxTE0NKJuqOsqElE92ySFewE96mU2v8nBBZnK2E/5AvjmACn38G76R5wb
	8zf9g6XpOC1+xSOMmvssq8cic+2dK1bLJ/1ehjjgVBmC9cySPrZLktU8mU4CwfHHezEXBUxOW72
	4GiA/acyhTizCZJB+/Kbf0HEAyQU/WzKn2oWq8BtOGoKRiQU2BXzml3Ch+b2CY/CHFh7cb4kyVE
	qvqig9MbbjsbMQb3EkuF4QmDF4gY4uq8Fy31/JZx5n/bmSdlCus=
X-Received: by 2002:a05:622a:7793:b0:517:b852:d116 with SMTP id
 d75a77b69052e-517b852d771mr103278071cf.48.1781016172032; Tue, 09 Jun 2026
 07:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004454.1239911.0d61ab0f129b.fuse-notify-prune-count-wrap@trailofbits.com>
In-Reply-To: <20260609004454.1239911.0d61ab0f129b.fuse-notify-prune-count-wrap@trailofbits.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Jun 2026 16:42:40 +0200
X-Gm-Features: AVVi8Cff1eiun0pqls2onW6vr8zEgxEW5ullaFeRLIWw4lzUG2NkzFTBP-9ApCg
Message-ID: <CAJfpegv-trP_VtXdEzhXFAUi_b2BEsv5LFxBaMm4so_SpFohNg@mail.gmail.com>
Subject: Re: [PATCH] fuse: avoid 32-bit prune notification count wrap
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: "open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 02:45, Samuel Moelius <sam.moelius@trailofbits.com> wrote:

> Validate the already-subtracted payload length with division and modulo
> instead.  That accepts exactly the same valid messages, but avoids
> wrapping arithmetic before the copy loop consumes the count.

Thanks for the patch.  I suggest using the more idiomatic array_size() macro.

>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Also please add Fixes: and Cc: stable@... tags.

Thanks,
Miklos
