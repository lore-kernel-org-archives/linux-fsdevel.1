Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420422;
	b=1eTJxJdvXR5ZkB3QQ2hw9OzelP8atKc9gq8UY+2aZTlSg3urgSrez+zZb0c8YtTl7w1/
	 qlOCAHGqP6CD2U1hholDB35BFpRXDcSRjA5eEnE7+xBsQHAr11KhMmbtdREaOjUYGeme6
	 yx5+zh6TgrRdPPsj4eHnxnqz1SW2mkO/1rYRpCxGoztswyhOYCWfYKgkYDViBXb3sA43V
	 9HrC28nZs5E4MPj8PDpiMga1yyi1AXELt30sPFkI5E7xpFpcUo3D9Npyf0KtDqYODYH3e
	 GLPxK/XTB+7Pu+98FQFafluRFORodcV5fwaGRqZBwmeaz/FKApPMtVspgTjHPad5EGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5EkQQnjmN4v5cLrBthc4MAXsVOryIg+2+wQmH6Hq2Yc=;
	b=xtHiwO7nAyFLizqGIQLLoprO2TfSEeQpb3b3YGKHDr2b7Dxbin42tTl0nntFAAoejTP/
	 I5rIFcPxnqTztXsEHvX+acxkxOrut6UnephST5r7g/hra1FKY2iX6Ejh/OGmUQ53wxN5o
	 cx1VjqCdhWdvuzWh/wNrLL/8zC11BLpaVN8uYm5OT0XW+n+sZj2T6OnN70vw6VqlWjIiE
	 sgMZhDrk1cD9vyBILHXnBkEd80OmeXlvUmIHwJjV7BFd0bMfOKZj0Xh8fdvt7oqflNaCv
	 nhPY7fOJmsHFIEz9qp2an7rO+GcAMmiijBqxizkmD2lo1Gqg07vhMlq1kJba6klVZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXE8xVcH;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D7606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 18:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267D7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXE8xVcH
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-491846221ffso2431811f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420420; x=1795025220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EkQQnjmN4v5cLrBthc4MAXsVOryIg+2+wQmH6Hq2Yc=;
        b=OXE8xVcHlE8HwQDm0SC7DnfUf9tLGIzpJ0FEqU0jrOo4kDlKKUykZNXysd3AA5QBw6
         Et+TZ5ayhWYC6yUHo48C5LW1hO++ukQbvv6QYAr1hY6RxpHRsC5fEg8NFLYhLFZayfAw
         mbHzukx+GWzZ5ts5XU3kkHxOsDBLjzl5K4BFHLKvS/4Pvsm5wsqh+Wxk5frTqoj9zdU4
         THPcwgkmgzKx9otykclh83IGFheIqBVQt8Yvv3P8o3Z0AQe/yxnXAoqrE7D8hrKOjzdR
         dIrGWRnQ+02HzqASMV49hCjTjvXO9szC+P1G5XLkFAQy2V/Q2NR4NWVFZ9cdJk7kaDSt
         Fz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420420; x=1795025220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EkQQnjmN4v5cLrBthc4MAXsVOryIg+2+wQmH6Hq2Yc=;
        b=KuPC1WAWpIGs648/E/j1derNXMGjXULSpOFeRhZ3cGHjY7aSdotntpHYnZnColU7um
         txeytkbBuq7xkbHT7RERCuGrFK8sNbW7gWfbW9IgJhJ1sNeKKHV7D3XVPlq4NJWsHJOW
         CCm6r2sT0KWHS+B4APQ0+PlYQTwH8rrrW8wVQWxc0GEOBmCQXyYMcpf11HmVTElSygj5
         TiPJEtJPmUrm1nV3shQCXVInq2V2YC9lKaNXAOELK7jaammVtSqiSAENz3WF8JZ61Cqe
         /h+pdm61thtRfXRq0SCvIOXmXGzzWLye0cX0GO5nm5Zyu+xj0ounVGe1dc2F+UhZ4v+o
         vZjA==
X-Forwarded-Encrypted: i=1; AL+hErHLeKDJZDKmi3r3PbBmVUW0XMznkdk1GFqF67+69ryZxndETeoTgSqADvaCiraxQiKbWZY7B9Zks3vckyDZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8XLCprhsTyuBuErh5HU6r+NWPdaBqd81kWgH9r1s8IlEX23Q2K
	3PRwkcz0NEOo70JDq3IdXRf9oLuRTw+JN/oP+pIhl0YFiisu8sF3Jjpe
X-Gm-Gg: AYBFou10vVjt+bBL69AY4RSW6nun5jDrFC5JhATFjWEyitJjcdsdgQlo+pJuY8g4X6e
	xD6fRE1Txi5N8/q6XGBCcFo4VQrCvLxqqqIS8B0ItM3gsZmYwSxrA/5KXhFR7sawDhOl93QvbGu
	yW4+gkqQsmbMaHXtq7zzd/G1dGrnUnm/O3TSJ5QNuUJ9TU3O4dSToAwD404QZ46PlIPGhnjOcQr
	O9QqfAMT4zBjDILMZOX7rLY7TsjpZOwLYJjswRaTKuZ0DXgpr08Z1xwISiq/Ak0dMoxCd7NoA0X
	gGhKNc6uAG2fddgjHw4CCBYLbgwxqg1TVMND1J1BsjcYyUSJ2oMe0Zq4N7z9xyzziGYY0zZGUzR
	B4tOFbjxIWYUOrfH+e/OWu0h9BrFCEXhYFwuvZE8UpmxcAt0yRHsgg2EBf5NC/+//zqB0JQVPdU
	8VpPxniCblFZ3PTAtIxfhLBezR4lF4v9bE6MpDSpH16zFHAQTt4GD8TKU0HTTcCR2ImTep6X9JA
	FSAh3IpLUkmnjajuz4o5Ocwl4fMCiSYc5R2/FMknPKJXi7zC6Tefu2ecnXEsXZ5BBMfauxR+NdO
	0I8tOCsVBRNK8TNQUCTU+nFeSsQlebYzealDMdgLXYKHnCIwAymN0wR+vy6GZkk12eSczv698uI
	tOn4rXxg9ksqigQ==
X-Received: by 2002:a05:6000:230d:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-499c7087c01mr6407400f8f.40.1794420420284;
        Wed, 11 Nov 2026 10:07:00 -0800 (PST)
Received: from [172.31.15.113] (6.red-83-60-147.dynamicip.rima-tde.net. [83.60.147.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbbe5sm13633793f8f.42.2026.11.11.10.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:06:59 -0800 (PST)
Message-ID: <f782318f-5ecc-47a4-9bcd-98b7aa696731@gmail.com>
Date: Wed, 11 Nov 2026 19:06:58 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hugetlbfs: report inode limits without a memory
 subpool
To: Hungyu Lin <dennylin0707@gmail.com>, muchun.song@linux.dev
Cc: osalvador@suse.de, david@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, jm5905938@gmail.com
References: <20261111130145.96534-1-dennylin0707@gmail.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261111130145.96534-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 2:01 PM, Hungyu Lin wrote:
> A hugetlbfs mount can limit inodes with nr_inodes independently of size
> or min_size. hugetlbfs_statfs() only fills f_files and f_ffree when a
> memory subpool exists, so an inode-only limit is enforced but its inode
> counts are reported as zero.
> 
> For example, a fresh mount with nr_inodes=4 reports zero total and free
> inodes instead of 4 and 3. This hides the inode limit from tools such
> as df -i, even when creating another file fails with ENOSPC.
> 
> Report the inode counters when an inode limit is configured,
> independently of the memory subpool. Preserve the existing zero and -1
> results for unlimited inode counts.
> 
> Fixes: 74a8a65c5261 ("[PATCH] Fix hugetlbfs_statfs() reporting of block limits")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
