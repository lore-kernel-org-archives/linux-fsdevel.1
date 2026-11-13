Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528319;
	b=s4vg4d1DsTc+3Mp2vAYxHQ+amgxwcqlFRiMeri4hm4Q49zsQIBzW+AE7/amrCfx+pH/f
	 tMkODPY4AFYPwx231HGJtuHNcC0HQLGO2SvMzzyFpQXedHNSo7DqmxAy6bqYITppv8WFH
	 hWlt2Kgy582+H3TNwV2YWu7D4pvYgUzziwn+lHchwrxOIrhPitbxV2uDyDH2Tszve0D3/
	 /K7q7QXBlAcJlp4VWixLzq4Fi1u62dK82L1LuTyE/zY2cQ9rAI9e8hOJCS4fMXXON2RBC
	 3caz4EftqMmfrsLUuPQSE9K8fG9y7bQ3m4yMyup3hcu/3osOB5u7pya8FchqjNxA+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
	b=Sa5Y4DiC5Ur1uH/wdXw04V3GDoJVESBPQDDOlLAcbSvZBFoLV+rwWXVuIbf4W2HzfeFv
	 wOgiNzYw8dI7wNOcmMPQ20Jtl5pJ99GlHtqR4F50FxfWLc3jLBicvLorOIzBKkpRWFEIB
	 KaTY6SHziPJ/wQKxKfez7hzwbsI9b6DpZp+pKEVdLKGAuKyY2rd2ymgvlN1eyK/OG7xwA
	 ODnHREGxSG2Abxli+1SGiwFvt5xh0D+G56AH4C4/MWrWKDXLK257fd9aMO6Z2nzDEjvNj
	 S1ChaIpWXmB7PtGUQHmYR9ulkK1rcXVCzCd/JoMxLnGG5gMdDolUazkhQ8aWwzSQP6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmDmIqDs;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1C606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 00:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F1C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmDmIqDs
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so129430241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528318; x=1795133118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=DmDmIqDsd3KGpm3pYfSBm6QfRSeIJaviqKbucIixjaB2kq+0Uq/HX0AqFy02tySaaa
         Qasz/xY0ZgxEaiLqbAmrfPtK8sdbsfG9DN5C8SYcR/++KtBTGbx00Bbvc+Ak6kUYclTj
         bLBS2xO10lpVwFda9Abuk9p6yYUi/hYA005qCZtVscxZENGD0FOgt+r7Dok96HK1zf7b
         oF2K6A5jk/ZYZdCHz1yI2OlArvWk/HXMFoIC8kBl3ssryTugnB9UXOyMZvA0LIMc7V22
         JFDZmNfldjBnPKSzdsK5KnSEQdhHWfv6cpmHKJbbrqn3ZzdKZMFwBoHJMgUPy6a4AAbC
         6s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528318; x=1795133118;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=fp/i5jA/LR7JdDJys4OKIsvCHbGTzJTBwdj5SQyY5M5+YeUGg3Ttz3E+ZZ8Whr9u3K
         a6FJd9FMTk5yH+w3KE62P6POZW4Nkq2XwORiORbwP2KXoyviyRhrcAjpYgGfK0K2/Fmu
         Ch9VCtr8bJEB4EGAD4UyYd7BeZ44m1rD0Gm8zQHSx8aZO8MGnbvr+n/vYP4EucGR5IEc
         RjL98kxf57+/7zBcvdVuV9Apx2SWvD5w+uezOn4vMK63DCFoedsKfILN8ntjRFPCVBGU
         IUhG58qU8lS7nffpASHdYgw35+tyCTd4R3B2qQZNT1Cvtl1q932E9eYbD+ehv6Kifspc
         zOgw==
X-Forwarded-Encrypted: i=1; AL+hErED5FX19o4nYryHMiPEzDLgOjFDnvYZHdr4OK12tJyu8vKVB0AoqkJn5gqZZptLtIdJ6r97+1kU1w25w2jk@vger.kernel.org
X-Gm-Message-State: APuU4Z9eNxo16Spq2Gi/DFCojmaTY9OcG5Y6rj9luP4CzEHXe8/h4kd+
	HXAfMi4bk+oLyL6lIhdgDgcorZzy+A1PYmb72e3IFUHKOLAYu5H6IVberYv4Rg==
X-Gm-Gg: AYBFou35pCPojeStXs+HEMrTj0QIm29/ypzJqf0nFOaEfkvfNStoZSTvknmuEuyslRf
	AEArJUnKyBtvccMwD2pTVf9zPpohigoyuDmD8zY40/2lCmYnLtwcVP29mbllz0zBLn1iNgjRnk3
	FbE/jgugjONqU9gWDNzhRrdWRr9U60ZCqBSe3gNxHV+vfOVc9wbCUKSuUmCKHUOAjzcinJ5ZR+C
	+3gHF2CfI1RhMR/OX35480KhJXfvx1Vs/BaJxCkpvMfXRjVQ6CTPqwYG0u456B1vcTy+lCuGHQk
	4mpzxNu5+e+D4qAJVTTydxVm+WWhxfFBU3IYxyU0e1shrhCO3bUsWdZc6eyc/iS5YfRc0ZrisQQ
	FIHvFFG4171Pjk1O3ZQnnJ0wcB0wfo2Ym6dSpF2ycVyZB5n8fXc91kWJ26MgG9TEEQDrDmczJxv
	Jk7oQp6rurQBsJgou1s81VHu5Xm7E310GPSWa2qYhTR9/1e32lMjo1BkEo37oA4gbb4xXi+gRxJ
	4LKo3Hdvqde9Tfxi3bv1My+eg8hYVanq0gGHea77+1/y44vHxcf6Oh+B50lNRGtGiyGd831RuAN
	l/v4MoXLmVo9YBK8E9yH2TZBFT6XrJP7s7LH+eD9xST/Qew4EgJL7gXlyH6biWiT7q0gklyj/7o
	4UP8iLbH1ePk9ObLLrnRFEs+czbzeX8IETtWU3as+EBsVZeN7heNpSHYcN/bW87Y8bLYMTEYmV+
	zcqxTBpIiW
X-Received: by 2002:a05:6102:32d1:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d64db100cbmr246150137.33.1794528316894;
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8424fb8fsm546119241.3.2026.11.12.16.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Date: Thu, 12 Nov 2026 19:05:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jan Koester <jan.koester@tuxist.de>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 op-tee@lists.trustedfirmware.org, 
 linux-fsdevel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31eb7df44411@gmail.com>
In-Reply-To: <20261112153841.1661720-1-jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
 <20261112153841.1661720-1-jan.koester@tuxist.de>
Subject: Re: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jan Koester wrote:
> Hi,
> 
> Building the UUID/GUID id RFC (uid_r v2,
> <cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
> config instead of the one I had tested with turned up three users of
> kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
> has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().
> 
> 1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
>     tun_fill_info() may read them without it. Mark that read as
>     data_race() instead of READ_ONCE(). Only classic ids from
>     make_kuid()/make_kgid() are ever stored there.
> 
> 2/3 accel/ivpu: the per-user context limits are keyed by
>     __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
>     only makes the limit stricter for them.
> 
> 3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
>     classic uid. With __kuid_val() alone every UUID or GUID user would
>     get the same one and could act as any other such user towards the
>     TEE, so those logins are refused with -EPERM, like ublk refuses
>     unprivileged devices to them in the series.
> 
> These belong into the series before the patch that lets kuid_t and
> kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
> them now so that the reviewers of these drivers see what uid_r means
> for them.
> 
> Jan Koester (3):
>   tun: read the owner and group without READ_ONCE()
>   accel/ivpu: key user limits by __kuid_val()
>   tee: refuse user logins of UUID and GUID users
> 
>  drivers/accel/ivpu/ivpu_drv.c |  2 +-
>  drivers/net/tun.c             |  8 ++++----
>  drivers/tee/tee_core.c        | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)

I only received this cover letter. Also do not see the patches on
https://lore.kernel.org/all
