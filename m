Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910044;
	b=CjtJoO1xPAQwtCpX6DqMXq+IP1aZZmh4bqJtWeilza4n9DsycjuYVnFjWfVXXlaPMzMM
	 1Lp2vXMUcp2k7+C6LXmCCvwmgP7IUCBbFrwcGMdCCT1xU2Yvvb+T8wLxkae18y6GnyQ05
	 d3wqkndFyuVBHvVWEQ8st9DNtRZbfCErhYDhB7INouhp31V+91ccfy7BaxOlO34zaCl0W
	 B9EUSwaI/CgK0L3lKgpiml6eNhfyGElrzkhGTJVjXLyMkhd+Y/KWOqrcdHqEd+urSjU7y
	 09Oe0Y0ExgwqcQU1Vasllmove9JSREFGzBhwdOy3No9N/KnA9Xo6Jv5cDWkgiO932FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910044;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fB0tSjEpeVMnmpusdLO+EDcnV7mxDkwNNJyyPw8a5DQ=;
	b=fV1oCs/uUu/kcHn54LWy8SzVTbkVNJQ354QlgI79Kj2Xphj9Wn0OapOlGr8q8jS/KmAD
	 NR/c1xz36jEHc+jkBtXXwl0NkIJSuenmTiCPpGJjbcTIXQK3Ovr4+DaU00hS0Zyyx7Whe
	 4Q8fNmcaiDLPDXYWX86pT2AGhT3C6rYCkLPiDO3coESQN4BCSF41OMnwyHk5Z8U1lD2GB
	 6aNJDHN/0acv6ttLkQB7yo19Tm8WY+ffAuoYW511Ej0a97Z1Lnf/rIt7uOMFbOPWfMxMI
	 r4HNLbIT4grJNF0gwzIawwgPPJxLcLmpRr+MR+76gqo6MmNuDsI9JXVDt3SH6iyylGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vzjwi1/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663A606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vzjwi1/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F301F00925
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910043;
	bh=fB0tSjEpeVMnmpusdLO+EDcnV7mxDkwNNJyyPw8a5DQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vzjwi1/ihkFoAigcsjfkg2CEQKs6biH845zIgKbTVRYy/vpbKFYOd+IMJB0bjGrh/
	 cOMnQmtelQkgqHo/DENNb58dx7XBh/Oubb7ybwMSdt40wb2vddliaNfKbyK0pDodvw
	 EcjfUpzIniqcvS533gHXt4a+1WFCFGVA8oDthHqVEf3dqfWZgB+ndHA/M1oIZvTf1a
	 6YCLdnT8+8OVZAgf5+grif7m7wwihvJUfA55tKiV0HMLRn0RxrCrSi9L37af4zAEzv
	 rbvUAtztKu7fl+4J+lYQa+d+3GaMV3StUHgnnVHLnjlPJXCByeO/isF7QbZMpqWPYE
	 XiPOVv12pbKNg==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-949664ee41cso324027085a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:07:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFhOGLap8PvH91Xy3fkh3O726IAV7ZYOuC2yCcPA0q3gZcHwY0qZzc4ub0aHjnYR2FqD837DSqc+EOQNb/I@vger.kernel.org
X-Gm-Message-State: APuU4Z9QYimIscxkFRPvma7bxsjUE8n2tzVrDvI0kiJC65QrnnrvQaZA
	AP6hczDhGR0vZEAj0tN4PYyFEeWve3OjwAznds+SW7ROZTl7BZcMYy3EINrsVVnRH+//ersote7
	j6B1g5v2heYSu/OiBdK6GPFvEedsEBB0=
X-Received: by 2002:a05:620a:414c:b0:947:84e7:f617 with SMTP id
 af79cd13be357-9494bbcc0f7mr2241604585a.64.1794910043206; Tue, 17 Nov 2026
 02:07:23 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-5-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-5-2f845e94dd50@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 18:07:12 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yxk9FpQMrU62bqVJP_yyffOE4QfCoH6-kWR2k7UDxw4w@mail.gmail.com>
X-Gm-Features: AclHuK9XqfHSSlV3-H8zXL-FPmnxM_EEINXhbrW6SExBJJw2kdb1xvGlKxX-YCA
Message-ID: <CAGsJ_4yxk9FpQMrU62bqVJP_yyffOE4QfCoH6-kWR2k7UDxw4w@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 5/5] mm: nommu: remove unused heap_stack_gap
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
> heap_stack_gap has been unused since at least the start of git history,
> commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
>
> Link: https://lore.kernel.org/linux-mm/20140430083620.GA4711@dhcp22.suse.=
cz/
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/nommu.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Barry Song <baohua@kernel.org>
