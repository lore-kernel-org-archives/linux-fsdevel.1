Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909821;
	b=mQ3coVy+v+M0yf3jRGAViPq433J9Ql/buCWlpXv1xeqOofkiM6DVo99opxR9fRiAYRrL
	 JLdqwqHElM8suy+t08qShVT6Pbz+fHEY2DARo4Qqsgre3Onj8JwmawhHJjJuBS8AH4H5F
	 bFmUkYPbOtymY/jKAI3VcnQVqo6uKfxXkdr3fso93BugOhzLZnTf9yGr5UAZoEG3S8tws
	 gZH+CXbomdZJi8dsPuSSzptib9YjzO/BQFL5GfNtPIk3mWjw7U7xGY1zLrXfk9ywaJqnn
	 YqjRsS9ZBfmtKnY7LQT7pr78bVlXYhHTiFTNmcG5XLpLEqhX23UJGmm5kpu7Os6hM0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909821;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G4SJkbbryGX39GBfapc5j9+NJLpHzq2qrYadOREFzZ0=;
	b=Vnd3I5zk/uMosReohc7veM2RSXwfkRydvVmuFeVK4P/pajZaHOG0hcCAkfLV8UToZi9b
	 Hsa3ytAlq+OD82V0m5TNnRUATq+IdPzQuEu+n7aE0NyfzvLyEHHECzGIu4b29qWhPlbtV
	 uC6+VjwYAjtvu0zG8vBOoQZvWYCfuGobWZBU0aTylbwLAUK3YnZVcCmiLxmr8LNntslXU
	 ixEmt++4r+P1jSLxiFOiR1kmnp6xKOlU5kWzfm6Gb7dtStuA3lHGNuHDkXbtPZm/DucXy
	 QRrgtyiTd36CUZHG9jZyAzq9bLk575ZF/5A7tI0nq+XJQsl+rltf+ZKRqYcVx604PYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoixdnlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0F606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoixdnlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3821F000C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909821;
	bh=G4SJkbbryGX39GBfapc5j9+NJLpHzq2qrYadOREFzZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FoixdnlM0ZDr7xmOe8IbRBHfnx4iTwawdza9bJR+U7S5uVnvt6/H4spWS3kMqQKGi
	 NfyTg4rxZayvCMUtsApRYHL2po5n8/eFKG/1Rtlh2105YgNEs43lGupcgSejLltmUj
	 r4z1caK75fCmr/z/52UDA2+FDgutzbCu3IkVtWIn5uczA0oDARLlDvD+rK/ZjjIyGj
	 k0cKzE42AY9wHL/p3taekgVhjyX30pXm5UYH0Rk4OL+YNt3VJyBhZHDLBlhSWJpR61
	 ILVZhLYlGQfqYkp3hisULgVRJnP5iIp3Afl4kNuFnrDJ5UPbEfxjz2dNLkmHsCzX8b
	 qVCq3hSYeK0mw==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so4777672e0c.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:03:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGO4+JG00gjI391FmuJeYoiFPj1pw+hQwYkUIaw/oyKKQNqZCSPRDY8++PQtTmLGPXGIWo6+c/Gsbxrc/qE@vger.kernel.org
X-Gm-Message-State: APuU4Z+JVAkVHuBCGDXtPqfODstUQRqWiFXyDoaqwSzPfhz6Kf9YBoau
	Vv+MDUQjl//rJJUAfGAjOiwXtQR4bXINgFZeKCIdCk4cJVVQv9mfSBxc3O0KZmP+FZvagvUfN2D
	ShOdo78lq5RnPn6tJb9KI7UhM4Hvhqkc=
X-Received: by 2002:a05:6122:3382:b0:5e9:176f:a548 with SMTP id
 71dfb90a1353d-5ee344ee205mr5276040e0c.0.1794909821090; Tue, 17 Nov 2026
 02:03:41 -0800 (PST)
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
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 18:03:29 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xpXzdWxp_B2kNXZmKCfE_PcgTr5adkLG==jEZ7+y+ZDg@mail.gmail.com>
X-Gm-Features: Aa3M54oSKLyjB7hd6iK-xbU9SbU3gd8PIMBq2jzZeTHI_Fj_ONDhoTV0tNIHTEY
Message-ID: <CAGsJ_4xpXzdWxp_B2kNXZmKCfE_PcgTr5adkLG==jEZ7+y+ZDg@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 3/5] mm/swap: remove unused folio_to_swp_tb()
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
> Its last users were removed in commit 0d6af9bcf383 ("mm, swap: use the
> swap table to track the swap count").
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
