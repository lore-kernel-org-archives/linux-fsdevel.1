Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909741;
	b=yIfuBRxE8k1EvaHTCI/6RBZROQ2ono09G9RG97JhufU3i5lOwPNQdA/znsdPt3URsD2n
	 qq5jDO7c/SPK/ql4AwU+dkkAgs4kOfdbhHeggn1lWpeEFctDXcpuukJYRlLBZ+kMH7sOc
	 FCx8lZC8vAcc/Ek5vARrFyEZcfL4KEbmTZOALZxGC2XP6+5X+IbQsv4tqZzyBuSwngOyK
	 7WneHDRBm/txYkunNYiZOZojNGmnlDv5zky5zonVSzCRT1vMc995dbQbZLSAmHrlkey+D
	 aqjGwpsyDv8cq202rtGXQfEwqn8CudgRXLb/xt83oa2qmfvPfIFq/St2LLMISyXBcQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909741;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cLK3zzOfhn1NufegKdCfvj6yMMyKmfBzXnjhXdQX99w=;
	b=oZfsmxpMDxO80QFzGEM2E28xVAu0x2hvXWBYQBdCE+F6DCcFiemXXuGQvkS2fiV0/xlC
	 EJQRAELD7v1ZCz53KZ1avdPOGh+Ez8SKGkgNMZYGAqDkPhmwXem/v8x9wqwU57Zr9+ERG
	 VcjppcNHId5g7w+9xN2TBtgtPtP9cnI13CkrTaPFWhVolV3cSSFOLLW1zzSwXIREavut9
	 0Z1NU9c57dtUzTAg5xhUgVlv4lVxpt9XFNygJKmfKJirufkGbNCmvi7yT0oHm0oXuWTjC
	 3d/j7q+nnbTTwB5HZ/pfjy836r8q2Tmohnv4Q1QDMzKsQR34ygl2H0jWAdYQRfy79Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7+BydlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50634606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7+BydlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52D71F000C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909740;
	bh=cLK3zzOfhn1NufegKdCfvj6yMMyKmfBzXnjhXdQX99w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G7+BydlQPSnynYkWinkxFM4YfGrecHX+svjDGOyD/KYsHRDXWX/yW470mlX45a2e8
	 EE93m/32G0w9nLRAOVet/9y1i/ogbpDK5FRRKre+YrcjvP1qAC3IvVUcMnr2FiobYx
	 ij8CeEiC49pZiNZOx66/cQrmdXKkxYzaplG4VWIxG5jUVBw88jljyvZ/YIhNAJDYH5
	 IlJ5BEKxfO1Jvd28VDvYv93KeLWZx30GRHIEefT8QPBE09bRD0/yceHtcGMQirLLEL
	 ENwfOMnzi1o67W+f7ssd7iyx6OhzdN24bGQ9tlTbTATSGYpdFUWj+BxIdpnN2RaqsS
	 Y9SJ9BmfObtAQ==
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so4368031e0c.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:02:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHJi5xY2kMXi+K9mg5dy9N2qgTtmUbAkiRWUZjmBLGEChKWwkq48SJG2ghHcF0xSujkaOfDOhCdeZBbTYb1@vger.kernel.org
X-Gm-Message-State: APuU4Z/PE1SFLkom00Hlm5XtwDNJjLYkfDTEdad+lqenO+HQmvmxJxDp
	YWjm93oRcPoDafTWCGtlgEF7AfXJyOEKfn2RjzyplzHcbFw8WB2FrbPu7UYWIIjI498I0EFYc5v
	zkBCFwm0EZ8l5jEV7u+I6nrYQrfi78MI=
X-Received: by 2002:a05:6122:8483:b0:5ee:3f2e:714c with SMTP id
 71dfb90a1353d-5ee3f2e76b1mr2651586e0c.4.1794909740230; Tue, 17 Nov 2026
 02:02:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-2-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-2-2f845e94dd50@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 18:02:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4whmBuTeoEtKzfdYKXaBp-9Ph7+Oj6xCFUWY8en+p-q7Q@mail.gmail.com>
X-Gm-Features: Aa3M54ozWLhKg1KFQokUO3ZjKoGTiLL_NX7NP3uVe-gz0Ybf495Q6LaRkAtem0E
Message-ID: <CAGsJ_4whmBuTeoEtKzfdYKXaBp-9Ph7+Oj6xCFUWY8en+p-q7Q@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 2/5] mm/swapops: remove unused make_guard_swp_entry()
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:17=E2=80=AFPM Shivank Garg <shivankg@amd.com> wro=
te:
>
> make_guard_swp_entry() has no callers.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  include/linux/swapops.h | 5 -----
>  1 file changed, 5 deletions(-)
>

Reviewed-by: Barry Song <baohua@kernel.org>
