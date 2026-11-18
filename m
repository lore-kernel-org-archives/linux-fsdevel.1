Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.231.192
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794967046;
	b=ULilpF+YhY/t0P1HfL8wEspof7huCrlfq2QvEfAWSsIibwGMsqWY7oB4mWoCOQdiSZER
	 eNupu5hRquxVKbVNGQLq82gWgi7/aXYhQhy7UNbth2hB5yrvzptKuJAPmkjARKySIAek3
	 7y1DAWY3d3/qVqSzwSmsWzJnXqPw1rNdNLxtDxm6JbgAuJmIsHZOcusKTlVwFPOhe5hrr
	 HD3lmekPfsCY3VjgiWP5zogChR+Mce3gVMtbTV/3psxmxCloCQ1FgAPz9qpv/qTP7waHF
	 OZZerx2rLPr+bl9SG7PjSfKOE/XVhxmeJfoAvCsS91OzMky7Hh9/AT0iM1MebrctmEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fPM4Z2/d+OWE/oPOGuzhHg0apTJ3Jgl1KSfNq20bq4U=;
	b=BqD19/XxWpXcetpbbTVD5Nk9uCShrniYSeg66gCFv6cPnJnxc3jhVVR3RYK8nL1vCoAh
	 VxYSzSiABrxIK/U71qRRH/IhqD2c+KQQfHvgNxfEUuTUM5xLG2rPyoPPQHZk7Ukt16Hzr
	 VFysCHrHn6mkU+0GmoatR0Lrc9CnaecUawe/F/o3rgFG5Q9PJykHACiYYgwFYOg/8MO6O
	 kPOgA+7dR0LSbc+AtLnsMgTQlb0X+XIxGeKb/HjI4g65PuaZc+YhlL8TjtSYLfOTkrZkS
	 B8o1lb6UC+1YNtq0xf8H1gTYWjCfDj1FKjMh1O7SSLRlXBlM6I/Qtf72vXsX4IocCeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjvjLRJD;
	arc=fail smtp.remote-ip=74.125.231.192
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D295606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 01:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D295606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjvjLRJD
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-533fe730856so78469b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794967045; cv=none;
        d=google.com; s=arc-20260327;
        b=I8WR3NDeIYCvVBnfrKsP5Rn/PzxAt/BBaLzJwwcp0jwfgXyeJo8yWVH8CFP1YYdkB8
         SGqzHd6bvUnJL8arUprudbk8fiY/i4eP5OyBimhKTWlLRzZzT+95BpSNFsfbqiwLqpvl
         t9bqh8ZqjlrMiBYnZsLdrEwsI6H5hN0J6DPFUPszrygyuHspM1mCk/5oipUhtpLCuZF8
         54q+SnlrAZYiaPQ1Ortcf7TiX8UTuHcdjotAuM/DSHiKqQTGkEiVdWaEhkfNzlPli3io
         vmq/5xl2oA5yxZNFiallpLkeAs/aR/j/VRZ5J2PK1SvSH9zDIDq+CTKkDAS1WJQcjpjY
         erVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPM4Z2/d+OWE/oPOGuzhHg0apTJ3Jgl1KSfNq20bq4U=;
        fh=GXRmGu3GMEmUlIFt2uDATW2v+k3FD0xvCwXQVSKJGEA=;
        b=caZONDwcMpHZbTzImdWAuy+6HjasbU+9CbazN1n8aq1FkTyvliXxn1W4yQjjvEDMJO
         Zoaao0Nl1L966U0lPjHB9DkCRglCeh4vYgO5dtD1GCcyTs3EYLvtWV2Pd045oUVzTgEU
         iXNNyVSwDNwwIw67++L2HK6Zf8S5SM/g2epQkmwek4+2Byta9U8cpXc13Ya6OZ+MkUH8
         4OXy29fgx1JWFAtUCCZmH5bupXC25z98jbnC02Lrp+vMpcleZvc5uMWDmcCOGkx9XHHe
         G9hwHLXzhiqBjxlUtVZQMRlzSea1cKKwz4V1ACT1MeeqhX0SUdBso9E395aX3GvmGo8Z
         rI6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967045; x=1795571845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPM4Z2/d+OWE/oPOGuzhHg0apTJ3Jgl1KSfNq20bq4U=;
        b=wjvjLRJDMo+za2NlWDbIczbW1gnm3Ppy84MnMb/ANoVKxLp4zwk1WMvzloaufYQudi
         /FYYh3TS1XtQAAw54xv7/p0DTlRrRA+0tikSecYdO0UfO0cBsDp3c5bp7FQNQ4ZbZqLe
         75CxpLjwbeRRDm6NdrkW7HWOl6V8/hcNsovcduPAsc4O85I1c6hWpobO3k6Wl5TE7x5f
         Gp6XWPyo0SeRblRRp4VgjBIf5gyh9OwhSftV3bKjrLi2Fr/xxx7dl3HHi/ec4nJaQh9t
         xUza+CQ8NnQCP0sNZcBrMIV8Xk1DPSGlG7NAyl8vhDczM7RFm1rZK9ns+NRp6ggQM1WK
         A5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967045; x=1795571845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPM4Z2/d+OWE/oPOGuzhHg0apTJ3Jgl1KSfNq20bq4U=;
        b=qHtJ5ZaDefBnG7voPUUKj2wtX0c6JyfG+eHlbIX362SYrSZlvM2J7DsPF2OYpATAm1
         ZAJKMpcM/mmjPw3LG5LqUSc8DnXxGzpMnQL2khXibdHauoU6GXCFp1g9xMj70KsVxEUj
         I0vbnqIv3EZ6Z0RmmXDGqbluIhwB2qrNdXDPYSdhFeeux3N76CJwKsPvrpkkGIZrQoyQ
         2PgH8kGPjB9A23oY+5TOn3EnpbWLNkn1cbzrEOvddzzfC6SWU56FLo1efNQWfzg+sjNt
         ay85EntXjubthMVj98hqb78XF/By2Krs+rZwnWT1gsFeK3W8ihYZNP7zQlipFQ9c8owS
         sJhg==
X-Forwarded-Encrypted: i=1; AL+hErEVtTxibC+NIqkxQENJiBb/0UmvIzUboEL973E6QBJUt/J0HOOwnGZfPt6RxMbEBljU0Joe5I/V5WVHFXO7@vger.kernel.org
X-Gm-Message-State: APuU4Z+Up5oDtAnf3YPqrUeFgRb3N2hbOoJip2Z81aE36F71uFdhPaOo
	RnK394svzYaMqsip9Bj1LKb+4/3ci2vjK3zvoR29+Ls0qrUTk63dR/WTwjSf4595bXBjjYa1evv
	0rVQh3Pibpaah5AjmSoey/zU7fCr5JHc=
X-Gm-Gg: AYBFou1f4x4oE3sensVyCSME4qy866xyn2qvJOZ1t84z81ioWjctlDtxk+7ycdliYz2
	TXYCt5CC+0jqWeJTcW8rpvTVrzQICervkWsQsU7L1E8FAPNEG5TxY26bKfnDGsI+3sJB9fIKuxi
	xB2C5HR4Zgg35Dc/TzsV4WbeYWBldKgfH1GW6dwkoxashSZBErnq4W+lDPSMr4M/TDEkFUc/4BI
	vr/Yj78jjawCBYpXrAvd1FRFqq95a8uGCJ/kAYpmWgh0e3wOEDtWwQn0xrqG/Hp+8YbihN8b3rd
	n8Z9ANXhGd96hp2PoViDSF6MBRukym14729oX0qkCHmbqCBxUzg7TmXe7z4+h/VPCRMEyDgRYlD
	hSuAC4VP8Jyu7+Do8tRxVFJKpOl/1e3MooOM0vKxvWpkthQyexP8bbmtUwUBpBeApyABUTfvOl1
	4g8Ynp3IHAoD7DaTJL+pj5TiBKNmAUawqYQbwihQq2lLzhGWXLixfd
X-Received: by 2002:a05:6808:23ca:b0:573:2541:1804 with SMTP id
 5614622812f47-5774045c9fbmr1927983b6e.19.1794967044731; Tue, 17 Nov 2026
 17:57:24 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
 <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info> <CAJ6F8CHzm4=ryY+j3ao6doR=-67Lq=3-w-kbhk1wdvtYDhyNeA@mail.gmail.com>
 <CAGEkeHdxaC2BBg5wWOCL0pj0r4Ks6mD_a3KpE7h+en9Aupb4zA@mail.gmail.com> <CAJ6F8CF5FF6-+Z6tOA7Gz=m_Cvxz-n7G=bqVY5H+fBCV3kbo_Q@mail.gmail.com>
In-Reply-To: <CAJ6F8CF5FF6-+Z6tOA7Gz=m_Cvxz-n7G=bqVY5H+fBCV3kbo_Q@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 17 Nov 2026 17:57:12 -0800
X-Gm-Features: AclHuK80GibvNnDmnk1ufJQUnUWv6v5F6uZQtv2GfalFtbrM8RVlito02JIyaSw
Message-ID: <CAGEkeHfywOHr225v1tm7zjf6ui2a2NttrPBwUhts9-DHLYszcQ@mail.gmail.com>
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, almaz.alexandrovich@paragon-software.com, 
	ntfs3@lists.linux.dev, regressions@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:27 PM Cl=C3=A9ment Smagghe <cle.smagghe@gmail.com=
> wrote:
>
> Tested-by: Cl=C3=A9ment Smagghe <cle.smagghe@gmail.com>

Thanks for testing!

Hungyu
