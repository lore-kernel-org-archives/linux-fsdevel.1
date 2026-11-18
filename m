Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019018;
	b=abvkbEdoLaXH/xgSGMmOmB300wnJUFb8FC33axDCwDr+T4Q49cF9Bds1rgJsFrJvdDJh
	 EG4Ca9oK7sB1bjkWLHi0d8O0fr4TjRqXXH7mxOhNMXkUxMVI0NTKRtB6Ex39ichhackH2
	 RcgH3783doJ4xxq9Enzj7liderBfCPdoXWyd0vWrDfya0Tm3I8n8cTJ2IyAdaI0//+CUj
	 FWQgKvfP+O7miY24sBVqiFCqjCBVbelQfAwwUaUc2nREKdFMgfJlfV3JbMhXzXPodNePn
	 W6Hg3PWM0UluoWJkNH8sdD2kQ+5A+4n+UhU5mPHlTH+PnhIQgwKbyGJQ+RiKfdub+4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZZL6VyLlbXFZof6UXR0IX4gvKyFon/J77+MT2G4Z9M0=;
	b=EVjl54A5hjQOkaRNkBslZ0lV3/2IamFoA0aAsS6XuTR+CqtJ2VSA3NbBz+rj/tkVLT/p
	 xiO6RNyZ9HF6vcDF1jOhbiSfIjBTwh7x3qW1OCkABWbUbdY53YkmKZIp7oEDKi7LQ0nCu
	 AKXkwUBMZ3Z8jUyXuvmOfbn2D8HFS1iCkfaFN7UB0nu3RulfBXOljz5+v5A3hnOA1twPf
	 3/klACsFnstyG+lItd4jx6/L2BqyE4IALg3/VyIDO8vPjbTVxX1srQLWES57NckMtyUO0
	 j4H0Px1Lsn+fQyZNDNTsAS67w49g2Xf3FWFU9/LX7I3rHSkboHZCdlR0bbxmGsS0xig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHOIrJqz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D8606A330
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8D8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHOIrJqz
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b467581b98so14498715e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:23:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795019016; cv=none;
        d=google.com; s=arc-20260327;
        b=r0L25dTNwkwtwqK2/gqjVieGcfNIjTNMIo/rv8EbGT7Z8HVco6MNV2hxu38azrwbhi
         0m7XeLgPIu39ctuNvNyOvBry2I6Dud0BClV9bXDSMmEihfoQsq0ofZxeEFm8axGqInS9
         hsSO1TEOqFv/4HErdzufkDskEiByiHZXl1WY2fUIaYzM5BC8PhX2ChmnTFdrS/SugfQ3
         nfkQWT6psRWHNAeuq5/L+GTTOoV5xIbYPCbCRi9nnbGqj+RZWlyx1tIsjPbXU1rCcWq5
         6H4JMeP5RER+iW2mrQwDO3nutWmFGWfkXBzUTT9hz4b6RS7j+s1DVjwVULsb3w5KsDdk
         T3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZL6VyLlbXFZof6UXR0IX4gvKyFon/J77+MT2G4Z9M0=;
        fh=kxdb8Z9JUlGmTVH6nfcKjG80XStNujnm/7Ya5M+O4EI=;
        b=qqWVWuPce0Kd1V6bhjBgTCc9CSfHa8QlCxB/exdJW7UJQWdqUm19dLVKLxn5u/bhRC
         V8rlp8edcKe2VFlqzaiB60NcVD8PzTiZtAGYi+bIWOY2WfB16qurEU+9pFfighbVdg7d
         wjLrn+otQs3M9tITNk+Oz5zrqWyod1p0ju38AuqrkJ9TvlSwhB2BDN0HUeWahcCax9hU
         spd/r/B4/b0bLzL0tLU/6NbYBY4lfDe8e092PhXrHwcFBhYxYDXItl3dJr2OT6PkO0aP
         UPsR2r9DNGdd3p0CjiO4NBcXw5wKHsS3BziUlFZKk2n/+YVc6HCHI9NGT5guWhbPcl4k
         OWpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019016; x=1795623816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZL6VyLlbXFZof6UXR0IX4gvKyFon/J77+MT2G4Z9M0=;
        b=WHOIrJqzbZ4onJn/wtW840vKnvsFlAgrptZhoxnYa/uYUYNd7ueyBmyorKWFor2yXU
         4SQ4mgoh+xuXa2ZF8yBrIBC2voVxUIhx9BM+S+/ru8EWeam3FVzyJ2hczPI156otlCVJ
         A8dAlNeiyJzJkY5whssv1EPDrrgAPEasfuknaQXKwHHA0Gc+TMbp2A2TgdHGrw4g6MaO
         H/M5WtbkNh9PR29qlKiTTW/xS2hqv4tFXbzPyU/60j7H1Au6T2SGr4RJkH1kYdKlgrLe
         BMs4Q23nohX26XfAPc0xPhh/65615tQpHFh4keZYTQjm4uy9sf4Lt1q5UExR1+kbmwoN
         lu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019016; x=1795623816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZL6VyLlbXFZof6UXR0IX4gvKyFon/J77+MT2G4Z9M0=;
        b=GWhhuIowk0WMw924NRryqy+Z/pSD8fuYHj0CgJks7StqkoxVen1lD3zL5JUZcLGFNB
         w2dHRw8RcjyTrVboWuq2u6DDFrR7CB4RzjJ6FRXWhpMHPTd8UFl1ff8kFEBwg7kMB4iW
         2WMSQgjqA7vr9hriE4PdolULlI2tLieBmuk5xgNb4WGbZBUyUbI5KC7PJzYJJUx1oq2t
         isSK+72NaTUZwFl3lpwN1q1FLODsLhFQ40p95VND67LPOaFvx8+xvhsRGFNZxjAIeuti
         sF3J3ufH4NSHvsF+rqQvygAF7Px50OP2V7l7pyEf1awpMCGRrCHhThfhcfqdgyPlP0NW
         7Mjg==
X-Forwarded-Encrypted: i=1; AL+hErHg5PGCAOcvw2XEE3fCDSgUy6lqUyVuKIa2oYXholEGk/VDKQ8CBZY3YaGGlSz8B91QGf5W4YnhWl/KweR5@vger.kernel.org
X-Gm-Message-State: APuU4Z8h8paGYCaXH0sXNnKuJsyiUenmmc5Ym6MR7RVVIpkINwc1tTqw
	RnJWenjpTQSCWi+XMKnDjvhDucZ2gFcdWvpixyFaGg6Pkn8gp7+hrRE7+VAnujXhDBEACG9/ORZ
	j+CqB7iDaVYsIngKXznnA8PWOZjofwig=
X-Gm-Gg: AYBFou1bvZJ46/HaHagMvI/mNo0ILPBJDYCoGaLhCQcjwkpkbGWWjEblpxi9Qzj+Gfw
	VIDSdcIOIpfdhrYCe/ol6QNHXlPo4ScwlDMErs0cONDkZoavdra3WGFoTdRCB2woZB2AuE4tqNI
	gtYLulyWGFRD08zGApHrWGY3pzZwPXL9D6+oAAx2o3PrXW+X1EkacDMLTAGVBoOyctQf7e/Ld/M
	f1++WuTkc3E/rpmWv1QDw9WzxaCYmLFYgOl+gxfvpSSx2D3FLmSugzrQxhGc1kObMN9qGW3hJE9
	9BDrJj4pYLOjSL/5+sUEwjhWG8l0K5/LfRmq+55jVBTk+8/QTSUGlne+C8LtVlj1wrEtleLPuSH
	wDYE2bm0yxxXbkxQZegtkye03pRELQQgp2W1ckonSdjWnLvyD6RZkOCN7yaaQpMPMFenLprqSn3
	/tpfvITumnrRVcCUQAkNeo6akyi26jBdP9qC8g3qhssP5U+mlLVyqWGvw=
X-Received: by 2002:a05:600c:524a:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4bb7d57f5ccmr65127875e9.0.1795019016429; Wed, 18 Nov 2026
 08:23:36 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-3-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-3-2f845e94dd50@amd.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 18 Nov 2026 08:23:24 -0800
X-Gm-Features: Aa3M54o1d3r4VOyC2nXueP0BXfHMpFVW1L51WNF9Ut6r4bdATy19jLSCJyr3yhE
Message-ID: <CAKEwX=N5v3Kyarttmxfe9TRh-mf44hx2kqam0eFzg1KYQcaEgQ@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 3/5] mm/swap: remove unused folio_to_swp_tb()
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:17=E2=80=AFPM Shivank Garg <shivankg@amd.com> wr=
ote:
>
> Its last users were removed in commit 0d6af9bcf383 ("mm, swap: use the
> swap table to track the swap count").
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
