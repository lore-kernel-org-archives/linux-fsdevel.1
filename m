Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729293;
	b=iJE/F79vPYBgAU+XaF/fHakYMsrEhAl9bYPJk8SdG+cFyYTJ26ycCYs9ddoAX06IyON3
	 Xf7+qWVK/fNpKAMmsY66YEbFKTHp/K8etA2Zni5k+GoxirlOVkmrTHR+l6uBxiei1efDo
	 pnQLcdLqUFPAicTKa0ceNSRkB4NSPATjVcg4wh8iBxCe2pdsj/vC1z94RHhfYFSOZzSB8
	 TKjE5iWnVJ0byeOIQmIBtXXsQ0YJYn1QOFGJmJ0vFNqkbrm0R+VM97ILqwnLTFeKWzAvA
	 eOOG2kInJWA2sSEOA8vJGW2dIU2tpt87xonY0YHsUL3f9+cfxFf88bUNuqTDC+jUebA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=XzdQYtOUXxk9uHo1ZAY0NXte1croEKcbZ0UJQV9jXv4=;
	b=cGlmqP014MccYHR8Ql81yUeXXmnJCWh6x8ywcmvC6K7d+NDLeP1BZTISbMOQUG4wAr8s
	 u9vyPzGu/+N2wHQ6Y0l6U8zxoF143sXOLVNBiJsHcIy+GctUa2w2o1skL4ZgxcbRfTPKK
	 rTdum9UgWCBnldzYXp4F/foY9DJ8J5sWT8xxcXjcOepsdNbbF29/qMaSvf/xvj0r6JQAa
	 woAyUVanfBpkpiR8ZiVg+bSndWyGdBwmRzFvu5l4x8fSKXv1M1L49w2EL22IGXjRatJVU
	 nmXldOQzNui2VIJGv+oedI92QDregjFpNBYeTf3ZE3DrByytvrbfn49wbxeCOriTCYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OXi3MjzM;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4113606A324
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 18:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4113606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OXi3MjzM
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-676804a3a22so3689394d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793729292; x=1794334092; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzdQYtOUXxk9uHo1ZAY0NXte1croEKcbZ0UJQV9jXv4=;
        b=OXi3MjzMySh7jSQdyjLEj5QhGBqizkgZNt0+BFbTjgfYnWeyEoPPnTikcPJrI+RwUL
         XdzbSiTlvGCLOjnAH96UkltFPSoUbWV4/EAbK6XCPxWheBVlWSqx+/RpwZ7c0p1O0Da5
         7fYXLUTDDsxyIV+uu5QbvR0/oVpkpexuPCQaYPSmcDIFGNlCcXgASyd9lBL4iAUAFVJS
         aN0F+s4R4HcBxe9wm1ru9MTfbuOkgfKhUxolVukU5zKSsqPYrTHC0PIHsDFZjgV48Lu2
         Uayh31FOzAu6iJh5pM2gMEmc91FtXFKJud/JZRtNX+PGBH+fyPHyKf6mnuMBe/Zfb0e9
         6mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729292; x=1794334092;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzdQYtOUXxk9uHo1ZAY0NXte1croEKcbZ0UJQV9jXv4=;
        b=quHivwB69AZkaN/vkrOHwHVY0HKkUBG31iQr61W9K+V7FI38lb8E9I38+FEeUx5y1D
         C6tHfONOkYuY/1K6giFghXY3QEhlK2lPRJZ3dBD6LZvCcpTFRjg6nsInHHmR0FrpHQ6W
         l+U2lfwDuQ6Sa04L3ZtCTVDDW/ieefB4H8fNlZ+8uhmu01cNn7tRCMHd4qnGlvX7mlA4
         smiXqlBWjhPQ3FDs0/jevONL6QERzXHQyeibMZvG7KXOtcym8oqnOEj9SsEaMO73mRMQ
         VWHPcd3BYu78GBObW1EvLODphR/TymPnru0bjWOQ9nanUkP8ydCwfXWVrDkQk5rhsSNn
         5i1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKy6EDtc3QiqeTk8OfaMzSTBmfgQ7TUjWuPgZiici5GVTicZIfitI82S6aHe9Ckwuu7IZPqt3m4HYIRIgY@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vto2rupV0sTOpRJrQeN9q0/A/2qOBXN4twM8CRW31ItNvvSMO
	b5zbwTInFBHgu1FVA4S2MTSoyX8WiugdRfmcZ/+7WlOsJayVYm+I5fqvTHoq5GD9tw==
X-Gm-Gg: AYBFou0Z3I2EPXH0F71CJTSxsOkq+k8uvRxN7u/NFuGpBgyo4qtSwFDCsNP9GRHTJeC
	XwkxpjNKkSIZDid5s7i72v/QkUYUtJvCzbB7zJZj9thrcf1oQ0AzyKBL5IiUgcMTBRrtUz0d3TG
	m8otJtJ5Fxw6RpedrtcXpIHMoDqO8BgjC8jwKRERMXTDqwJKfvLy6fYf0vYAZQHojBJ924XZ5P1
	ywACU1TPUQFKldlcO9RP3/0s/BbxeCpBjbS5IO56AyKKY59VGkJd2WMQEDYphwb3uINjkzoLwL7
	rtrAtT8HYr4aFmxtFGq0nBDZcNsA/98Mdl7S9z4je9ZB0oax8YdMWn+dVko+QUrCM9b4jVNUMYb
	segbZtkAQQQ/aKSQ6BXTUVLLqOP/ElL0fqWwe14VUU5H/8SKAoyPJ8S//vVe7MOKBC+RaGbsWoX
	IrHGxuhhLTKMgEH7OzJuDFleaUbHLMjybGWMRY17XjrftG59/OriOuLnokDcc7XOGevfKpJenGL
	65xcLk/id6kVRVe3zwpvc2ggXU1AEEIdVDLQAExvPbCg4YN+vOqnS0r5MVsXChKUuHFZxsyuKtQ
	z7rZZvJJLnQ7iTBz6Frvyagk99RkKRknWGsu5/Tu9hmGftNNm4E6Mj7zun0/7bwZByT+CQW5hcA
	L+8qMudqtpUnH0jU4vS4Y6Nk=
X-Received: by 2002:a05:690e:4141:b0:67a:8648:a87f with SMTP id 956f58d0204a3-67ba507da19mr9462809d50.79.1793729290959;
        Tue, 03 Nov 2026 10:08:10 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3700b8sm7600510d50.23.2026.11.03.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:08:10 -0800 (PST)
Date: Tue, 3 Nov 2026 10:07:53 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Alistair Popple <apopple@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
    Brendan Jackman <brendan.jackman@linux.dev>, 
    Byungchul Park <byungchul@sk.com>, 
    Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
    Christoph Lameter <cl@gentwo.org>, Dave Chinner <david@fromorbit.com>, 
    David Rientjes <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>, 
    Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
    Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, 
    Jann Horn <jannh@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    John Hubbard <jhubbard@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
    Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
    Matthew Brost <matthew.brost@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
    Muchun Song <muchun.song@linux.dev>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
    Nick Piggin <npiggin@gmail.com>, Nico Pache <nico.pache@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>, 
    Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rakie Kim <rakie.kim@sk.com>, 
    Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
    Uladzislau Rezki <urezki@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
    Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
    Xu Xin <xu.xin@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
    Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Manfred Spraul <manfred@colorfullife.com>, 
    Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] MAINTAINERS: TMPFS (SHMEM FILESYSTEM) updates
In-Reply-To: <c301fb04-1144-4ec9-a41e-3c98fb569e0b@kernel.org>
Message-ID: <e0ab5329-db66-ed89-5d6e-b57f7fdd6753@google.com>
References: <20261030-maintainers-v1-0-97278f8a5f54@kernel.org> <20261030-maintainers-v1-2-97278f8a5f54@kernel.org> <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com> <c301fb04-1144-4ec9-a41e-3c98fb569e0b@kernel.org>
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

On Tue, 3 Nov 2026, David Hildenbrand (Arm) wrote:
> On 11/3/26 09:27, Hugh Dickins wrote:
...
> > "SHARED MEMORY": should ipc/shm.c be added to our list of files below,
> > as mm/memfd.c is? (Though both can also go off to hugetlbfs instead.)
> > Or do you prefer to regard ipc/shm.c more as a client of mm/shmem.c,
> > rather as drivers/gpu/drm is?
> 
> I would consider it more of a client indeed. memfd started out as a client as
> well, but things escalated a bit ... :)
> 
> I see that Andrew is assigning it its own section, is that good enough for you?

Sure, thanks.

Hugh
