Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048225;
	b=mNf2QsZl/3JHqQt06Oo+tNDufsPyr8JY851UrdmZfYKdqkTxhSd56GkG5NzFzkf7yEOX
	 /RoJKMbRO783aRnMPWtQdW21VssWEPI6lWtxjfEIhk3/13Q1+TrmE/7Yrn+25biYfxOyj
	 C5Wm174/9oNYVwhJlKL4mjRk2Xn5sJVAKumLP6Rxa1dliT3OU51HJthVYEGtpCkiU79g+
	 IMfeFnlm+R27xnmE2OSnqaIOkkNoTNPdqMbBqJzWkf4CiODORrkW+TLK6rKKT5haWPmH8
	 DBbfoFF+V/+nlxfd1K6YS/v5FSHxcUQPv0qIcdEp2q46AzRBkcMRDJv4vmHnzYgAtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048225;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zFo4l7j16ZsDQEUF+stMjRBTlBJ8Z+3F5xTug7lrKcA=;
	b=3pGkGbZuxvhtLkMrA+k0ZZv+esccCe6Om6PmTb8e8TGpq8HvCjx9f3LR8f/3hcmQ4aZc
	 YomMkaAy16WPbQVrGvb6C8YUzWRxf06uktDKwejz8BGcFByhhCBxctmD6VBFQlhB/Ch5N
	 wCPU9AVfNre3FoUFOZypyjP/BGbnFAeeOfy+4CLxkerswo2i3a4vjaooSOcqsjMaUTX4Q
	 u509Nw7aKZeeerTdJMh/sEaxXmiJJK+cbm8yMfr7wBdbxihDhNp85dq8VFwcMhG4d/v7i
	 V69k7s+R+Lsm+B86HNOoNc4VDzJV9ZYaadZk3iqzc4a/cty4XHs1jx17bUtCzfWmnjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E4606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A68E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a70b241fd6so1375485e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 13:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048219; x=1793653019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFo4l7j16ZsDQEUF+stMjRBTlBJ8Z+3F5xTug7lrKcA=;
        b=EQbsbR1RYH03IiWpqK0iHbyLGvVG9hYlQqy5PNzSyvLE2iESd4L3LslaY0SfEQakvW
         pdGc8pW+XYHvfcMqhJKFavHAwMyU1DKGP54dCWKJ2kXqqsgW2ATDkrUqYaiuSoWwlZRl
         jC7bkwR23gK0jvSS7lmrMHuajQ0LwlT1y9ToR8/3I6vATqzM8eynQfZHbYPT0gpE9PwA
         IJLEFbIccwfB5rKsjTLjFiMCawQ2/Jn6juSgvnzpJrAEr//SeJrZKLgRsU3JPQkyimmX
         UoNAFX0aZYCO2naPdnH3YYBLhoaLq3aKQKb+vD+GpKMWRQTAakGPbwerV1f9s5auy54Z
         VRcg==
X-Forwarded-Encrypted: i=1; AKwUvBx6Dm+kzjK6/FWjnq3WiKzkDOFuAiprpPvI8Zm/JYiNU6OsavbBvTpCX68LXMi+pOPClxAIe1unqzWtccGY@vger.kernel.org
X-Gm-Message-State: AFq9FYKIMpPL1iNJ8HeHb8oxPtPlAnm97vqWIOP24ClhOdv/Ge551kvi
	7HjsPD6Oa/PLaXtrr8ekId0uvonZLZC7rJEqMArEUgJITDNRV4dEWzwe
X-Gm-Gg: AYBFou0ow6oVudOxMpBl/LNq0MDX9ctTcl0dlYJtE84A3H428Qo0YoG3Pql5P/1ska9
	vE+my8ubgSjm/E6GLn+O1EmxVQ9QXaBOomMSjug9MBYkAslpRNODubLyXbROXcocbv/S4KGXRs3
	B4XHpoISQh7t08N4B5iV82aEt68NUP5DgIoNJs+30LM0m+STwf7AfVObBsbswgMMwNXj30gJ84t
	5+uyQ6jeK6nWq3aRyXyiJTpr/DfzaSBcJQYjl6A0brgbXcWRtVQ7Terf+mqglSf22Y5qCLr2aHM
	5y+N/XKbxZ0Jlvnr/eEw+966zGMa2+eCHpe5aIGYSthKW7Tk1GzGmx6zHaR/yPtovctCUZqhaN2
	urXv0zZxLwfR8D2T3Upr4EAuPyqKIQBGFknu1vDsN9LEzbcHTHlIfvVxf3/R8UMnF5lNYReNL5w
	30QAHK3HWHdTw5JiRbbAtL+BOoT/vZRZrQi2J86DTyo6HDQBzQ1K0xecHYs9lY0UohcOWD8fWT6
	bhyiGiR5nFamUJV3fCaUqUzi0o9C3bYLLO7k3LQCVyl8muz6HrgIu/DnZRKrStoBJt3zdyUfKZH
	fmKAjQkgGKiL36Y3BbeDBLSRmUnrz6KlfNQN+eY=
X-Received: by 2002:adf:fe50:0:b0:48b:58e:6cb7 with SMTP id ffacd0b85a97d-48e3eb91422mr11908114f8f.6.1793048219015;
        Mon, 26 Oct 2026 13:56:59 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48fasm18401915f8f.31.2026.10.26.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:56:58 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: jack@suse.cz
Cc: brauner@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aurelien.desbrieres@gmail.com
Subject: Re: mmb_sync: b_mmb NULL window races mmb_mark_buffer_dirty
Date: Mon, 26 Oct 2026 21:56:57 +0100
Message-ID: <20261026205657.88074-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
References: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon 26-10-26 14:08:12, Jan Kara wrote:
> Well, yes, mmb code is all built on the assumption that each buffer has at
> most one inode with which it can be tracked. If the filesystem tries to
> attach it to more than one inode, all bets are off and we give no
> guarantees what happens. I guess we should add an assertion to
> mmb_mark_buffer_dirty() for that to warn about buggy filesystem code early.
>
> So what you did - handling shared buffers separately - is the right fix for
> the problem you were hitting.

Thanks, that settles it: one buffer, one mmb, and our fix stands.

The assertion in mmb_mark_buffer_dirty() I can send, if you want it
from here: a WARN_ON_ONCE on bh->b_mmb set to another mmb, before the
NULL check. We still have the module that attached shared buffers to
several inodes, so the warning can be shown firing on the same
generic/241 run that corrupted the list.

Aurelien
