Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924426;
	b=EvEUhXCxC9SePmecZFQohvZ8BFP+9XODJ/9H0u88tKVkMzuml/1wx60hzId0Vw7+zYB7
	 9RdAGDWOX2DoHSs7TJJYNip1ZR6yBRM2klH86rqgmwX4icdpKhJF9VyosyHQvwRKzpNkG
	 0PnojUigJRzexffiJ4PLxZ3Wal/Q2UJHQ5OLWotdPnp9Twalm5nDSvwjgGthMTAFoltL9
	 VFWE5k2N9zlLMuU59zDGqsGeXmhjqyRSZ084I1gHX1bvinlrh7LJMQx8Gds/QFQUJ8yvh
	 gQ/oY6e9Yi15hd5/q0OGj63c5hDcMRRACtpdEjIKNsQiSFR/MJl5kSzQNYq2zAZMX9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=x1PMpSXB1r1OFkmXjhmoKzOBVvwoXs6UzqD2BMYgi9w=;
	b=Z3HJImit45jw8UHkYpeQDmALTCLbsxKetgfQokALaWq8z0rN4cMdJ7iJhQHzLtL9Kv6o
	 DlBAfYPWEfFACQeCJ/Kg+ORPed5gpvzQTXshwI7dZkvfLCaSfkuU60mWZALK+ejAgMqex
	 FnkHJuJ87ixV3n7TOnPxwnx5QvnuItzPdx80exEPy97bgoKzDvW5Yjtv/qonh7djY9OVY
	 tMEZCfX/uTfPZtu+5V2LYnO841RXYY8Z13t0PRa7tipTFPWe4XBU2gtURFzSRM4zwBYhr
	 CZvwflcj8PyoKSIGujmFZ104SUyMn8p5itSfaLKm/Zq947CQP4K/leJNvuqt2/NBGPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=XAETls5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791F606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1791F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=XAETls5y
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-949680e6d83so290212485a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794924425; cv=none;
        d=google.com; s=arc-20260327;
        b=S8FkIuE1eNGtrniUPyHVgBIzRquGl44UxGQ5K6/d4Vrd89QTGokDKrHyqIO6MFgmJ4
         33e7hHk7Kr4R3cu7GUSFVILcJvunjSmZWMY0lZpIon3OVo6mZPTX2kX23Gst8ueXkpdM
         QFf2uIUAu/htOqpuc5ww48VA82BY9vT50oW2DrxLcVIcafPFiKggemFHs0Ojsu29/eUl
         hmNn/tbwDD4MYx7U85Nz29233Hs7GUlYp/odiSQU+m8ozRd60Zyel3M5OMjnfwxpAd9T
         3Kummbs32hLO8gRuVhldsLIxZ8KeCiuRn6o2ExxhbbRND+Ogyu1U4b1cyIags719dQUS
         Mbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x1PMpSXB1r1OFkmXjhmoKzOBVvwoXs6UzqD2BMYgi9w=;
        fh=0BpcOpzCzEXCbUTpgf1sjev+mUUDnWAqTSIP5b4gwIc=;
        b=A4X4kOmJ9KTBJQs4kAEmj5PlanOeaxoFH27NI5ZvXBMV3thB0sgDFusOQP8xqZ1zxv
         rS2QM7iPDR9VP0Ec0xgOVFKju6zYaJOJSLD/PI+oPxKbwGMzi7yLPttxFyULAm/kyyeQ
         ngUQWJYJL4QE79c9+8oUmS2urd92ZAJWPP2GQzgxdQuTEJQoI764djc8znttzdR8Qkfe
         WJbU86tg+ifXAS2HDgy/M90dpJyw+ema5y2fBwfYD81A1kW2ZYgPTaIN75GWmX08whcu
         odIty8xktHc92B2KCnEOEBdYypD/rmlcSLyJ2xCo7t79QsXFep1KVSOJa+D2Yg0iyF+h
         sv0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794924425; x=1795529225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1PMpSXB1r1OFkmXjhmoKzOBVvwoXs6UzqD2BMYgi9w=;
        b=XAETls5yjXa3iG7F123RbBGHzGrx+Vija5l/AfjVzJWpqRLHIs7ijlXOJ71VIakroZ
         dw7RL/ilcxHKGSsrbEXh5YnTbhiU/SMUZa69783mjfQAnKl3NFIX1Hhte+sTPzNG1+7/
         spn0KIHxa6PTypX3R6nG7Ik4nb1TdiDF8lCgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924425; x=1795529225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x1PMpSXB1r1OFkmXjhmoKzOBVvwoXs6UzqD2BMYgi9w=;
        b=xYfCYMHSgTcHSIx9HOulS7n1bfCujQjlGqyHdUAgzpCIxIo6F/5w0AMASmCiw+f+U0
         6yD6s7ldENsoTZRXt/sVZ999Vi5+mfR3Xivkl1QyS2TL/IsUXqQgffRgHgrIHTbQFezf
         YejLuQUaKihzekdjAkVTOLOd0rYfJZnmdL9Wxi4JD2CGIEzuEc313HFDCPTbkoDxnbSQ
         rRz1yn7bo2fS0VPC9BYulIU5ZTeuzjogsW9PBQCX7MMpeLP5N2b5A8Bk88Zpmt9dzjcX
         cIesNmFMkIm6ASCD0/RM4B65yJfyrEw8T+ZMpBSZoESTVbMBEwbJXW8AR/uZB/UVKRE3
         vDrQ==
X-Forwarded-Encrypted: i=1; AL+hErE6UK/pTUE8ql22DM401mMdwD3CVfLQPQhjOJwd+6YlTA4yfYO8KGMVzr1IFfiN5BCM10/vbwa/fgsmNmSO@vger.kernel.org
X-Gm-Message-State: APuU4Z8wG3IDwfyTu1hg3a57Oh69MM46c8PJ51tHWj1eVYGZRTZXzjps
	Brz1wcOEHstONl43kWt2JQH7s1wxQuaevBpWpJVGDiW4qqhrmYNYKJuUwsBPkVyyJJEj7MwCfrH
	t0zGNiHlzHQzYiJ3HekfoPmY8zbmy1olGqxCiUBxHZQ==
X-Gm-Gg: AYBFou10GnHF0yBB7XkB2duqj5i2Av9kV2pCh8ISuYyPfjYYdG0xyru5iUPVv1LWxoj
	gGGSVSbvBlyPIQu1rRkAJeH5SLC8QUiW+4HAO3TH9ANedvEq/QeqytAcEL9QGu553Gd/h+KKnSd
	nZ+GmzYhhFpYY57ZS4FyZqlkRhvrdo6GHeYs9VzDOFr0D/ID0/tNpOeYYR51wU5vUaiKXVKEBaf
	pOd0wGg9qvvY4LucyWapqtJ2bgwa7/j2aBPzr80P9d7WHfCq7Kh46xWY+DBWZf4WgqLkacbJ0x4
	lxY2yg2SBMED+YdaChlRzQeu2h+bkwWR2xXWZdO2cvh3MWWNcRJurI34XETOOEGM805rWNE/jUc
	C6CgyAtqV0Vdef67yjKX+WbFCfjQu4TUrEGUSWnJbw7TKmbl0IXBXs81EuiHdOkgJeQ==
X-Received: by 2002:a05:620a:8394:b0:944:dbd:8253 with SMTP id
 af79cd13be357-9494bc7b8aamr2034423485a.59.1794924424868; Tue, 17 Nov 2026
 06:07:04 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
 <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com> <CAKLmikN9Aod9Va=FsqkRmF20=69sdgdDOoV_bUuGh6wTykVcBQ@mail.gmail.com>
 <CAKLmikO5y916zgeX_UFqfGQ+BUmNC6uvHFR_bsizeTJu4AwxcQ@mail.gmail.com>
In-Reply-To: <CAKLmikO5y916zgeX_UFqfGQ+BUmNC6uvHFR_bsizeTJu4AwxcQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Nov 2026 15:06:53 +0100
X-Gm-Features: AclHuK-jg6F3I0kg99mlIx_XFVtVAv569UkGYtDtRYivNkgNJwJN-1RoSdv9luk
Message-ID: <CAJfpegs9wm7JWBSqY6eFj+9JeaThE1RGtdxqo21_ytL1_okN_w@mail.gmail.com>
Subject: Re: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate()
 and copy_file_range()
To: Mitar <mmitar@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 08:58, Mitar <mmitar@gmail.com> wrote:

> Not sure what the process is here, but how to get this patch further?

Posting it as a proper patch (e.g. git send-email)

Thanks,
Miklos
