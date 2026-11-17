Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909884;
	b=KAii+eaAJwhwl2zjLQhpOq9mgFBY86DczIVYr7ofxHGTttDcSgcTA0xqi5hzyBCt780l
	 s4wyh0GSHoCO/A4NqIihTZNWJtZwjDaklusGxXHfBWVPOKW7fe4+kL2hpcNxjElZ5sn1Q
	 OtpmzAWXcrA//vwGDobr21+8l+qfMkuNNxjPJqUIjrUzXfd+jRAC8Tvi3Uj5wFXatznHj
	 pzENRa4OkbTv/CQceFid7tpkQr0eGgEzLeEM4xDrZPjFtDoi+eEBKZMSc0iylzG0/o3Pm
	 EHSrywrXjks7Si9tGndcNg0b8b3Pjypwu3/PqbvkeDGHfrGmrEodfMtp6sx7ivNEg4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909884;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w/Tj+yOQGHlgMdHJ2zoX2kGKpzAY6RpKaNTOi5Zt6rM=;
	b=dFUe2c3jIS6I3UjP6D3Kca9SI/tFHu66TcD0dJvF2OXCgysJT2o61lWA3MWViFFg9xow
	 R5Bw6P5udhcLuWhsqMokndAchMWabUANiSg/fkEzwv0BOk9HtXEjxdOtHuFQW5KvJR4W8
	 RJvq6vfWRVCOTpFNP5oImNJBiy52eyjxdrkyZQlmFDQX5yoHclOP4RmMPKwS3Q3oP/uuz
	 OXRz4lgk+7gGLT7oI510jy6KkkGR9BPQtDzoOqHj/Q5oX1UBakLGa3p1E49ozYmc5sYcy
	 GVVB/kwQOPdddieElEaOkcZ3xYGj7i5juSrpSRLJSb/bEuyvbMFybGKcLi2frQ/iMiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0u9DNVA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F257606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0u9DNVA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C87B1F000D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909884;
	bh=w/Tj+yOQGHlgMdHJ2zoX2kGKpzAY6RpKaNTOi5Zt6rM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e0u9DNVAMICPOaGQ00G5l3VUdjwKqXhcWqtNE3HYcRy93xGW+rb+l657J4dC32smz
	 OvNil7dtuxVr3u6ZfbIlqxbJuBbWN9bTgPKO7MToNhd2nAs1MhQMYrrh2iISEnuaHJ
	 0ds/wTxNtInls6vIiGQ8tGSrAwRxuBOpEFiX/d7uR5ZrDPI9QrhIGP7C1NdOLCgMXM
	 SbXdatAJwX3Iw2DwYlr+1JjrtXzzZC7LAsT0nAx4pxrqjNMfSh0+BwzeMElA37YBS8
	 Kacx9430eex1JdHXbGX2NJiTjN5mj/c6muFuyo/be8UbkTaXpvZlu2q7QcRf3jIydk
	 iJfFcHNSpdKvQ==
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so1160156e0c.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErECHhllDRgagOvcR1GisMyD5++38fLa3tHAFCwA+TpelGaOS+cMT+rNEFny/0u86Wq6iivpq5+Zqe9WK76l@vger.kernel.org
X-Gm-Message-State: APuU4Z8WN+TnzOaDg0g+j+3JlHLQSalTxvO1RWHwN0G/4U7wN7dbbyHI
	dMXtKq8rhE+LoDAHXAO8uCpKj7tVxE3rvNNn0Tk3sEAC+0XXSaN30NCjC5Mjww1uj6wG2+qRabm
	2Oa5trHadyxWd9FdgrX5XVvKG9adls7I=
X-Received: by 2002:a05:6122:2891:b0:5ea:c11b:432c with SMTP id
 71dfb90a1353d-5ee34a7d16bmr4305139e0c.15.1794909883279; Tue, 17 Nov 2026
 02:04:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 18:04:32 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w-KED0S8kzVy_4B93DTKVpOgAoP40CRtiyv348_tiKvw@mail.gmail.com>
X-Gm-Features: Aa3M54pZMronU9ebrmctqqD2wcMMdI4pxY04GKVdkValZaPDGgB_Qb3xjyXwYPI
Message-ID: <CAGsJ_4w-KED0S8kzVy_4B93DTKVpOgAoP40CRtiyv348_tiKvw@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 4/5] mm/zsmalloc: remove unused zpdesc_lock()
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
> It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in
> trylock_zspage()/lock_zspage()") but has never had a caller.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/zpdesc.h | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Barry Song <baohua@kernel.org>
