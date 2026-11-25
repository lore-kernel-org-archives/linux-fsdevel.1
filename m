Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795576418;
	b=4E/hYgHcgh6bkWKjeDeCEH4onzcLnEZVhjYXSqR7r9/oPv5EGa1Jpelbg4Y0nTNBo963
	 DahFWaRdTOXn9+4nl1rs1gaQ0nTTYqfxk8dHdyoCLT4NU63oo7X2nLxNCw30cW2ukwies
	 z+EntSQbTvcRwaRnMdYZBb6ZBt481L1XUnExwF320PQ3cjCoWaaFARMudVZRfQB4ZreJT
	 2jYc491AMSN4/J0303Dl/DtJhu6yjUWuuy5jNwcxTIm2nllpLmktW+ey81chZ/KAgfWNG
	 SxamwxEErDqiNdVPnPtPmufJs4UJg1XCEMb9/0MIAkzhrxJu6741nDugyx+HgHyMJPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
	b=JbaeYP43h3ucCxGKOaZBqDCVkcHbxe0VS+ogB6S4iMkUwWqpM7tMR7qtjRzpixAmXoQe
	 FhcldoXSPs3EcR51V05SQlSAv9Su15xZqPlq2LyEey27f+MxdwXcvziyRiUjwxJ3Tg30l
	 wFykXHhgArez0qZSeJb6qvyHnuYXsOqpY3NRsQQT+slkYyBEIoOOiJjSvNt0d4DFJ9Nah
	 +VKPrxQdODxXZOgw1q4GLkg5jLRNEaPn3l3uqxMtqS4k/QJoL7cmY57FZu6p6Gowk6xSo
	 4oR/jd5apF9pD8puJ0Op1WnxgTJ6/hwS9rvqcS27wQHjTt8ivKGkAkGkK30xinrE2fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXmdTs58;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EB606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 625EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXmdTs58
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b497279c25so1316903a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795576418; cv=none;
        d=google.com; s=arc-20260327;
        b=m3AO+rfbS9asdavLLdChdL+5nlvJ6yA/pTRNgrUkocUTau9PwtCxE77y6JawDUOnVQ
         WuXfS3Zjrz10+XTpJnCTjv/2oTxRO3WWvExvYzMvD/zW6BE1USeI+UyViysaYxDHvPdg
         I2QDGqITBEeyvYI847TZWWlXzD7f0OkSJd0N/RkgMP88ynE47wGbUdLvDruHe9VhV5c1
         34Ee+RYlwAxC7/KK8JFy08H0mztmLGyL6R89NxI6JOxmfdFaVTmR7vuhFINWWTV0envF
         ibNVJAxIMW8uzKGygU0lBT5zA4R+vGFkWxwzc3rEzjg8FyNukLZAF5UK97neICrNXUPq
         Go4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        fh=hSBbGXkDBk3ruZN/sOwxyjspE1KEwEg84xzkvrkB28c=;
        b=WYR7t5sI5ZlGmmFyXx/vsayBpYdVKm1OgZSzEziQZ7lLILmkn95crhChhavoJmCLXP
         3s6QwVitWtm3xoE+Pz/MsvPedk/zI+NDLmJGrUYqHaqhnIgMAwVdiJDiS4pKQ5uFcPCs
         VpqKFmsr7DICH/onO1+GGUmXuTTeAqOXCLVX7Q17F5RZ1j3tp0xRAG5MC+oUL3Mm+Ieo
         sS0YI76A74wFsJQKXesFqTLDpxwbiEQa8QJ8HZd/zXQSBL44mW6MvmsxAxMhxg3PXCNS
         tcLvgFD7sTXsCFNPvTz1si7YU+UXaIzdL8+v0OOatqbyqx/0BuQlJN4a8YNPpZKHUJdi
         6bEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795576418; x=1796181218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        b=rXmdTs58n8JfEdQZ4HJe9pcRzDlBQeJ8CGNnQxZY9c+zSkk/5zUpxc5Ieu3awVsTbo
         1xDLVWvtEr5GNBNnsjB7e9TithIelqyGPJFxWAQBw70S3tFtNmU37c1INdWp0EknyzKM
         T1139q3oLAzi/hXRzI2Jrss2DdbZjCHcZZ0mKuvVeo3QskAtNhZ7TeTHj743Utw8bQLP
         n2sLt52jR6Sz1UOwtUJ2xlW7zoiLQpqnaSCzW7nrSgAzWgqaGJ4Z9jipS/AJUQqxNhL4
         sZcJ2jji6rFEGT+lIolVduLzCtkXWgXLtB61dIcFPnRXS5gO41XMwYyCOTVdVbQZtS5O
         Fx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795576418; x=1796181218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        b=rsGtXyqxlIVwGEZaprG1RsCUBFxSYCZHU39hnpyPFrliQ+/S69Qv7zUPLIKHJAlxXy
         t9KCnhZDsv5spry+DwyIz04BfWSfV2YMTt2px9hIECIE34f3SKrAF4Nb7TW1oiGKVs07
         N2+zns+5XXlEjq14wEV3BBNUDdPWXuvNdoPAWHD37UoXgs2wKhqAuB+lI7V6P+Taw38T
         pLqw7Hc7gKv9JZxtHTr5Blq0LN1V74lYofR6QM9Ed1bnXDzpvaHgfF5w98kidaZv4IP4
         lkc9M2eEJUpX0Xrs2tLPsWKglaO3952XuDLBveoYNSVELjb2csIPtyCl4YCcOnRcQXkL
         HXTg==
X-Forwarded-Encrypted: i=1; AL+hErE4xlnNvZDg6taIEndsPyOZX9oOp1i1x18cSna4H5wkTDzH7S34eEQd/e2wszhOT8WQ3bsnIkXbxK446vWh@vger.kernel.org
X-Gm-Message-State: APuU4Z8cMTHCR8hG4FaJpE6y+BR3va5bynyNi2GFmU9z8Vl51MuxO0xR
	r7n9XMmDQgQFtVORP0YjB7TxG1h0++I62pkf4N7QHcjITzFy+Sv8dlGv0q/Yiei5qXGelzpgMnp
	xLpjqnOAmpv25hq/8Dnp2+I2xGBWIWX8=
X-Gm-Gg: AZFdTZdXd7RAKzHCqaOU829pyLk2rD6ussyrBDylUmpzkxsGWFTMXxR2leTorjk8EWQ
	BM6Xng7m4mzC25+IvBLuNOM4KKI0k/fhkCn7Yny0hHrPQax8SccalDogVFF/ZDrUFS5/ybKtbuT
	2U+IC8PyiayZXz0RQA+5fT9QH7aIHHwbWQ46k0/nfn58l4fmnR2L9p/dXl9TgXvAgo7eQIfzkV5
	czKjvA8Cus8BB/yLbyw364JhFzMfDIiEs2ItMmIWUlqIblqG7EK5HzwYVUnddQRWCER2J5CO46T
	g+vPPoTZzJAgjP5+kkRnHIOkQvCUREqx+FFOgo8tMkkz+ozKUmpusXZfXL6eY66bZoqZDXsTl5H
	5u7UqYjerjDxZaqHGPhRXxEOQDrB92bWEPs6lpQ==
X-Received: by 2002:a17:90b:17cd:b0:3ab:4f1:4f76 with SMTP id
 98e67ed59e1d1-3b41c900b24mr15919769a91.24.1795576417688; Tue, 24 Nov 2026
 19:13:37 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
 <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m> <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
In-Reply-To: <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 25 Nov 2026 11:13:24 +0800
X-Gm-Features: Aa3M54pnXMEK0Eck5BBUuqtUrkvY1nVqb3SO0OotTOKtwJph7tvN7_xbLx5Lf10
Message-ID: <CAEnQdOrzP9wKwmyuySRch=a4B5F3Akgsvk9TNUj1Vycq-4JZEg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +1. This sounds good to me.
>
> Henry, would you mind sending v2 along this line?
>
> (and maybe add some documentation).

 Sure, v2 sent: cachestat() now skips the xarray walk for DAX mappings
 and reports all zeros, and the behaviour is documented in the syscall's
 kernel-doc.

 Link: https://lore.kernel.org/linux-mm/20261125030432.274396-1-bsdhenrymartin@gmail.com/

 Thanks,
 Henry
