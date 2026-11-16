Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865227;
	b=Dpz/akKG9UzDI2Yam+uhVXkiDeFAfBoeNao/py26yshWRrClsfdY+ZWo3X6xqM95XbzQ
	 hWB3L6qxhgzf1QxuBMRc9BEIPqudtGkBhbjmXirnR7mXmPxAoJEv/nQ1jPpqGXBp2WSzW
	 Ck4WB63Ga+92y8af99wPNvJhApsuEEbAvU9eaj1doQNgbpgNCJhV4/d7NRT0swolX2+xU
	 F0k8ID0gIG8sUFuwW/GJt9Uw6u7MEDQ7wwixS4Niv2E0snxyYhaXtCqkDJx7vz5e9MDkS
	 5U4WxKJO6se9Tmj01f/KsLy5ZGmXASqtI68H+yhO0rveN4m/I07w5FDVRP3/NFshGFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=guxuySiDjFPex5d5UZXMSLCVow0xqFx3SUNRdh1n/Hc=;
	b=b93hlKhmaMOQcrOcmhKhIifazoVqumSjKbgIjlc4r4tJB/pxHFSN/Si2j7aT7MnnvqXJ
	 +xr8MfE7vlo003uiUhnZaEvFO1cQMG7YjAmkBLZwKnAMklGRpgQ6+Ems6L0hp+HaJ9xdt
	 YA+uOCswlNgKzUSaDDRi6pAaMSgt2WqK30wxp6F37YDHbsNX0RcOYHV7nqfqFKRtm3VZC
	 28ZiigW8ikp35p7nl2G1h073k1nmTLmRRJl8OzHx/JjzcMuqvAx9bew1lljvTSfW32bIm
	 plaEKwu/6oRdPrGIUA99r+0BHP96YmSa9UILiBTnN0Um/NXiThliuldK6BvyUXOLqfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKkz0+AM;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AB606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 21:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35AB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKkz0+AM
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2968612f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865225; x=1795470025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=guxuySiDjFPex5d5UZXMSLCVow0xqFx3SUNRdh1n/Hc=;
        b=oKkz0+AMDMXN2MbYaume/5ijBFXw2UEilp1YUcXVt+/1ijvmke8ziYe28kMFlj1dHH
         O9uDX0mi+CvYhudeI/1woWvvpsubxt9cNyMJqUbu1C4OeU4k90mFRq8Bur5HuAaJTANW
         4SSxDlm4EuxKFa+baVVg8QRRZvr0+7zbbm2zOdP1WODDT6FoLKMlqsGG7aHqwrGDCmxn
         Q2ufjBSVd3RVhPFdeVgyi9SYNlRaONfjCqXzqCnMq5MJ0TShxxikBMrNQbNJsn1dkfOG
         mwltvcbwZoUDZ/UfHLijw6cNCrdFBk6R6G3a1nvoQI+Hwqmk4UTlit8sFsegqQtq8PhE
         4F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865225; x=1795470025;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guxuySiDjFPex5d5UZXMSLCVow0xqFx3SUNRdh1n/Hc=;
        b=SRHUDA3RpQMabqcEtjHo7sp3gC1f6gLBnjByxEzhjFS4eG0rYKD3w7rFTNE74S5VD2
         4TgtqSnLd2f2I2JYLfZ+hl3YCgHMtmsYUGhXEKTw02JhZMIy0vRHAlwN39bOsdA4PH5q
         VPrIq5gsZV+peEG9gXippViC5eou2faWEfp+CC97nlfOAYidSwMKerI+IhscHCTH7Nva
         rcbPn+JBuviS3kue2Ob2DkSOgzyCH+p/dJzWCHPptj5vws6lRCGPsznn/Z4vCDTCk1lz
         02r/xRcDWePRXJlE4zTzFuyL+i+ARlUJtOKPntXZ+G94uSA3Zcgk6cM/qYbQKFUEpu/U
         APRw==
X-Forwarded-Encrypted: i=1; AL+hErGrpWr/G1in9y2qqz89sQ1bsimooSrhXdq+eCz6B6cZfIb841bqyVVawugn2KqBVppgUjuqYOFFjKYmF28L@vger.kernel.org
X-Gm-Message-State: APuU4Z+eotPlPCqjVpeRcJtWlPCW/Coe0RLvknfdUqN+pu8LMfH6sD8t
	YzQbJjHFSZXDd8iTnLlg9X1juxzUcPJTewsq0rDcM4f3y0xYaX4YeEfy
X-Gm-Gg: AZFdTZdQB5O128id7WSp6PFECFowVtUJTio9pT2UtTgRvafay0EYhtcVhoeWnJgcPqT
	CNeBWrdDiPa7v5ixUSe02/BO/UuMKWyfedKw+LGdVp36HM9JzuHsgNdx/nIp5wFhgkJ96t3G46W
	1tRXZOlbFJstcz3jx8LfB02ezWGmuCcMFs4p8cq4TWwLaDs84af+O+6B2R+3uXmD/aMolZkis/a
	QT6vcFXiyAes39K7/iiM1zduhYwWpMItUfLBvRxJNGSYI7ffpEcGTcPDqrhtIDrgDIa5qd6JESu
	AOAdjkJnarrqAIsmDkfUTXjWKRRuY28tng+vm90siM0N3PPlhxD6EwHQJcLCMJPxraX93nQw0aS
	RMUhaKkCYhaOgqIjELNeaY/sdjcKQy70dD3V5a0TbgnM+ksP3T8Tvgt2if6aARH+cRJcXrv9/Oh
	0qUX12bY8YCzp/d/vKK3+iYi5ievCSb8XkJIUFll7+as8L8xasRGMFoQFjq6//jM9qnsJcN51RI
	lorXrMbOvUQJSK+DqbtY9Jw1m4RdFQXGpb19YeeXzHwFvr1ZCJJEv5wMYL8mvxlrg2MrsDL2g8A
	R3nYfLjEX8ZJFDUIPdqQP3lNzScx5wlGLMcUBoePaUg43ZnkxIhhm0mm9hzDcCSKiSTin7bDxAP
	WX6347pW0xUU=
X-Received: by 2002:a05:6000:2602:b0:48e:7476:9205 with SMTP id ffacd0b85a97d-49c71784d80mr25910373f8f.31.1794865225021;
        Mon, 16 Nov 2026 13:40:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm23985103f8f.12.2026.11.16.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:40:24 -0800 (PST)
Date: Mon, 16 Nov 2026 21:40:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: wen.yang@linux.dev
Cc: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers
 with typed bounds and core stride
Message-ID: <20261116214023.1a1b4205@pumpkin>
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>
References: <cover.1794844686.git.wen.yang@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 00:07:32 +0800
wen.yang@linux.dev wrote:

> From: Wen Yang <wen.yang@linux.dev>
> 
> struct ctl_table has long relied on extra1 and extra2 pointers to serve
> multiple unrelated duties, including range limits and caller-specific
> context.  This series addresses both:
> 
> 1. Replace bound pointers with plain unsigned long min and max fields
>    directly in struct ctl_table.
> 
> 2. Replace per-entry context pointers with a core stride mechanism,
>    allowing callers to register arrays of structures embedding struct
>    ctl_table and recover enclosing context via standard container_of().
> 
> This RFC focuses on the core stride infrastructure and two representative
> complex users (netfilter nf_log and IPv4 devinet), as suggested by Joel
> Granados.  The remaining treewide callers are converted in a single
> squashed commit to ensure the tree builds and tests pass cleanly.

I think I would have tried to avoid the indentation changes - just to
make the actual changes easier to see.

...
> 4. Baseline rebase & conflict resolution:
>    - Rebased onto next-20261111 (aaa2f954c21b).
>    - Added proc_dointvec_jiffies_minmax and proc_dointvec_ms_jiffies_minmax
>      to sysctl_check_table().

I didn't spot those in here, but are they even needed?
Without the bounds don't the minmax variants behave like the original functions?
So it was only necessary to add support for bounds to the existing functions.
(The only think that half makes sense is if a caller uses extra1/2 for
something else.)

Related, I think you can reduce the size of the final patch and the likely hood
of some silly errors by making the 'dointvec' functions treat min == 0, max == 0
(ie no initialisers) as 'no limit' rather than 'only zero allowed'.

David
