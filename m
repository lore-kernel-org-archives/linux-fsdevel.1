Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550922;
	b=U5AfSR5uPjfeh/RTKyh+9ilD/m1jOhHR7kDtF9OR5AGEJormyD4/1+xddUjE1wmXVUPn
	 iW3Lz9dQNqf+6nB7PK/WdJI9Vt4v+SF94sa2Bcx5+CHJ4QI25ou/Sl1IBymDpFKKPfN3t
	 t4G3AgW0k22U2pM06eR39seM5i9gZWik3N2mADL55LLvTZBLTIEpeHFmEunzBJ/2PcmS2
	 UbkmDWlSLJi7nfe+JYAtfn6Hbw3ZI7ltxdpRsMd1I7CVs3VTQ0q7gZ37QZWxwcW8xG/bc
	 LN/WQ3XS2rZg6Wvf+/p5PgF837xugdzRie3uKfQEMUb7PLmHFakd1LBIsxZmzCAs5MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550922;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YjP3QKnL6hdPkyCUqoebq2EqaYVn4Rzbl+nO72ucugw=;
	b=KcmX90WhPPSDAF4pysfBkFOL6kafEl2bVNb16k7pnM9L9FTILrc8OKgyURR/HVU4+uje
	 A0ZSnu4ERg0XAt814+mfKp7VO1JCSSuLVOCP1MWCWK+5PdfelNCpQYv9V0UbaAclr72zB
	 u9OaoR+REmxX4aD5uvCHU46SQ+XiRJOTddxnm4eOzB9YiCsz2P3YPmiLQmcPOsvrprE1e
	 W6vH1FDBcs4+Y21IuCQSCkr7zU/vUL3TGJb9sM2JjsahFIRW494yT/Q2U6YeFBLYGHnTu
	 iRt4oGX2QTfjrCMziwn8+G927+4XUL8MKgWMNRyefQNUcp5idFuP9qFTwLM8415/mFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtgcIIiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1659606A324;
	Sun,  1 Nov 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtgcIIiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9E41F000C1;
	Sun,  1 Nov 2026 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793550921;
	bh=YjP3QKnL6hdPkyCUqoebq2EqaYVn4Rzbl+nO72ucugw=;
	h=From:Subject:Date:To:Cc;
	b=FtgcIIiIxC5mhsREebYXXcY26MyqElKXddG8VSV30z/XdvQCFIksXl3c+v9GjMtuq
	 QtuU0P9aTtsZq8v21syWbho3OiSBZtdEDa3ECISWv4q7zM6O/HGhlHQOxW+RqzAM9I
	 +QuhM9jgjSMjzn5YuILlDB7v8aK0fsbW0DUQGedr1I0kOLSTNJq5vjVHZjLNaBlsYy
	 iq6QV6Rf3YtNPSsaU6wdiwqTvKLr6FNxxlY/W0rQilNl3wJfuYi1Q/ZVAeinf1d9G0
	 38iSbaHwMgS45cUu7ArhCVNfyBcfVkZdGAEEzA2xz2BFF0k56k81x9QnUyVrECNdhR
	 vBL59C8rcgqng==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 0/2] MAINTAINERS updates for page and slab allocators
Date: Sun, 01 Nov 2026 17:34:47 +0100
Message-Id: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChq52oC/yXMQQqDMBBA0avIrDvgiGjpVUTKmIx2io0hiSKId
 zdtl2/x/wFRgkqER3FAkE2jLi6DbgWYF7tJUG02VGXVEJWEH1aX0PMkT57nxeDqLSfB9m6pbWw
 91jxArn2QUfffuev/juvwFpO+OzjPC697uwR7AAAA
X-Change-ID: 20261101-maint-page_alloc-update-78d176d4f4ab
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=C3HW2TevCH2Yd2fJl8QWGaAZ6VzDZANnTLuuuAbT5V0=;
 b=owEBiQF2/pANAwAIAbvgsHXSRYiaAcsmYgBq52o75G20DZ3UsraA1LZSlqLZzWB1h+UWekpAZ
 tOz7gPFZB+JAU8EAAEIADkWIQR7u8hBFZkjSJZITfG74LB10kWImgUCaudqOxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQu+CwddJFiJpJQwf6A67YgTfbad6SIv1DxHNedH2qfkDT0AQ
 /oSGN+Ld2mcfLbvzkNYWDEPgreGMZ/RHkMe3/gbQAv0gZb63cJewmGqzwHcu9JOjmzUd8NIm431
 RVq7Tq0adY7QI3YxnAzerSMe8MHL629FI4j1G+1rICz4msmu0romeKm8+vcaOxAvEPDnP0qiv9h
 62+HGQhvz0/D/ATRogB39gOG2F2F1Vov1Bg+5NOUpPUHIvIAOuF3qF+pWu/hmirOHpOnQWDHeqH
 FxbOre8TLgzSmssk45V/kxvTYU3E2N02ntAuX6VXGvyjC3fZGCuIVlpCrIRq/p0l3vLSLpg6KMA
 R8fWrjZoSdg==
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664

Following David's updates [1], perform similar updates for page and slab
allocators to indicate the MM process transition for these
subcomponents. Importantly, add Johannes as a page allocator
co-maintainer.

[1] https://lore.kernel.org/all/20261030-maintainers-v1-0-97278f8a5f54@kernel.org/

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Vlastimil Babka (SUSE) (2):
      MAINTAINERS: add Johannes as the page allocator co-maintainer
      MAINTAINERS: move SLAB ALLOCATOR under MEMORY MANAGEMENT

 MAINTAINERS | 63 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)
---
base-commit: 7161984021cb0605ae2dfc478072ab1aa45a2c67
change-id: 20261101-maint-page_alloc-update-78d176d4f4ab

