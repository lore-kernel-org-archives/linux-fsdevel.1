Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CB4A3402
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579587; cv=pass; b=WOtdTrfUWkf/amu0BWQVSd7xmzYih8WqgSqi88wMTbDNqB3zT3F6FU9EWfNjT5P/2IArt/lJ6fyR4xKyZMlV1E95d/pM1yjmwF1oAUzClImB0XbcEPeUJcIAD3ePsox579R6dLSQuoZAdeBrgPUo04OG/W9AJJy49sIl4NLfsfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579587; c=relaxed/simple;
	bh=BopkGP6sR0jaJSDk33EwB++6pzeuw4tOdMU/tnlaGSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KogTkB6ym9T/Ldv03cYxW0/SMEsVN900IvAS5uulMOlJLMbr+85LE6FaSv1F67ala4uIigd7fXQQ6DnMR58eIIUv+LTEvx9xeJVfWIWVr8MNcoP8uDfvtycrDzEldty8SF35A9GQg1RvBmfy1pUR9m9WXHMGEDhrM8llc6ZI2wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lEgqD4Mz; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lEgqD4Mz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5ad864a6so53577481cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579584; cv=none;
        d=google.com; s=arc-20240605;
        b=kZE1epnlnYuJxL2avGVecaFAaMs8Ft1wPdPm+3yUBM4Mt0xw5QcIBISnhEGZeD8WMg
         BRUKKkNYWDiZjpRcz5P4D3bFdQ1Uk1Ht/JW9GcVIRYdpeKBuucwaDVk85qmeV1w1Raj1
         meHpoQUuvKoN33R5anqT0Iq6hqnFRN7a9xrMXgqNAWd7NCbfKtyVzXpOufgkZwYGiUus
         EOcsR8vHf/Se+6EipmQItbOfBHB945msvyTztumyUQIdswpz8cuwx1Gn/dS9LVzZVmLW
         pve3ZR0HAAaipvkwtcmr6s8gvrQmQaDud+HrBQRyK23Dbva/185S9URfBMIIx6Ir/uBv
         H+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gyI430ATZEUVsPLqfTNBmTzX/MQNs93/RaGxRDZTt6c=;
        fh=n58EBo2H2Echjt6n2EQz1c5nLYXbQtTnQzKJHBj4JSE=;
        b=ZujvjESLVEb9ukJW34qsFInSn0HQSGPaWZl8k/DejIEKsEUI6ymOSTXDm7L4nAgrfv
         bMT4q+CccFfMugote6oZ2oIxD/0zazBWDUlIFMvHsyekQcUL5/eEAnOnll9h6fGlPtTH
         vNMQ1a5dW77JMJnM7mMF1h+BfyUDT5R2dqcx100NppSmn6OvYRdyEvlZFqnASFd+37pe
         KUQBtptjxsVZGWHhBJ74J+JVxX2X5kTyp1idFkEeVmHIZsGePnJaiQAysRiW/CjeiRJI
         Zht/3/hSOWNTNN9DiQPzH8U3a7NQMmIG1B2FIR0/VpUFzruSFGPG3f0Tslh+j3A4aVHd
         4BcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778579584; x=1779184384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyI430ATZEUVsPLqfTNBmTzX/MQNs93/RaGxRDZTt6c=;
        b=lEgqD4Mz1grjoKnQmqrov2r+EcnP1q0mYOouDkl1m7ZWhefs0UtoDfiY3UqQT3Vyii
         9nZyawpzyPJ4SX669eRo6AogRr+qXvjDcyHw607vM9gSAYoGpuvtuIz+2otrjlmx6A9B
         X4GE1LwdDtiYPpNOkbBePUpv17EVvj6vAsOkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579584; x=1779184384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyI430ATZEUVsPLqfTNBmTzX/MQNs93/RaGxRDZTt6c=;
        b=sZpo5aYjg+wqaZRnCcefN3rGDkZggF9UZnN7+DXUVzkrABFtWWxWY7qDH0WiOmYiJJ
         Dxjo3EFY13yVofjBFJw23BL4LTuM5MZdRF5Whf8GSZ9xT7ixOHISiTsuteTSHrymPKBi
         3auAqYF34rp+T9PAFoxSjinmwV2QJxSL+qbm4+1qdar732hzzaO0iCEacnxO2ujD21ql
         8+53GWzoxe3AMsIHhd7LiayX0vS1FelsbkKLQ6Va9leybtN1TAeRXkAM0lYz1fMFp24T
         YKx8DmSQMktifSKnbxcVZDHviwMD4k5VAyj6vb9ubbDszHI7T/hPnL6Y9DOb6lsDhH/8
         bGhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eocbFnLmXHzBWwlZ7DfkZi3GPu23VQI3ZzYyvOrjxPM3w+TcYz47NTI7xP+YlYYzlflXp2L/LEzYKJk5Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Y/T0+MSvOtZIaKNAnbfc9vf5wtk4FMCxD2S0FuhV/5YNhIL9
	1t+T44mH0AqY20uJQ7AqxoudMoSdSIZebM/05pLKjLiTX+ikSPCa63oDRdU1w26nYq59Pyj1WV+
	XQy3GYNBl+1oaTm1u69f/t/LDXN5InIIlkDeTwrSAmg==
X-Gm-Gg: Acq92OF9i5vAoQLU5QFBnyz71RGl9kL0z5SV710AlBVGQ5rIiqvJ2YjCLJEuDOD/XaO
	qw/VD1snJFjNheveAklxYWaYxG6rI/Lc3etVVsTlz36efDCiHFFxmFzgVNv3qoSVcVtOucVdA1Z
	DRaKY2qTIDIO+J6+9MFosWeQ77PWeYHAvtMF/q+eo7hUXoM9S+xWfw8qEqD27EDIrfNYB8PRBkA
	hDecI2keHmzsi8s21+rk1K6HFjMTUYNdQt5MSaMFF/mGILIHvdXLu+Qzqpi6lNgbon8dqXyl7sO
	CXj8DlRl/vxzm10fwby94k3rgXNAqVxH1MTu+/A=
X-Received: by 2002:a05:622a:a0c:b0:509:39b5:a97f with SMTP id
 d75a77b69052e-514d20ea85dmr29104771cf.29.1778579584613; Tue, 12 May 2026
 02:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 11:52:53 +0200
X-Gm-Features: AVHnY4ImmLfRayTFq-7XJcPELnNu6qXF4ycVL2F7gsipXLlyh56_8XOIK6AZ1_k
Message-ID: <CAJfpegt=eWS_6ZfRsL_P79COKJKoLGNOsJ9g6TkrAhvhSbb7nw@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Amir Goldstein <amir73il@gmail.com>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 19:18, Amir Goldstein <amir73il@gmail.com> wrote:

> IMO, FAMFS sits somewhere between PASSTHROUGH and IOMAP.
> The simple nature of the maps, the fact that famfs maps are const and
> queried at file open time makes me think that famfs is much closer to
> PASSTHROUGH than it is to IOMAP (in its full capacity).
>
> I think Joanne has mentioned that her customers have a use case for
> multi backing ids per passthrough file and I assume this would be a pretty
> simple map, so that sounds pretty darn close to famfs already.

TBH, I thought that fuse-iomap is just going to be a generalization of
the passthrough interface.  At this point it seems like it's trying to
do quite a bit more.

> If we are being honest, then we need to develop features that users need
> and if users need features, there are usually employers willing to pay for the
> feature development and maintenance, if we let employers know that this is
> what it takes to get their users what they need.

I fell that this is a "politically charged" topic.

Let's just say that maintainability is very important in big features
like this.  Even deep pocketed employers can go broke or change their
priorities, so we need code that can be understood by at least one
additional person with a different background.  I think that would be
a good enough guarantee that the code is not going to be a nightmare
to maintain.

Thanks,
Miklos
