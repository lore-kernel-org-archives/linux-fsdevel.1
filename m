Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469286;
	b=iSv7uWcaVeSGp8Y5NK+QGgAF5G9PGJDOxcJ8hkYxUmL71KgEuQRMoBFRKg4uYJ2Qf6kS
	 RBpmmM0VVZmMAODEYrsMFWysdtav93GUX3JhslHep6YNCpEeYWBVqdPz3ncXyBf3KcXIJ
	 y8mNfn9LUXSYp1PjgO4ufdg81fNl19Tw3UBa+Z63RiYvaQzPA6At7bXBaH0FtYVu1VMLX
	 D9E3kLCnvYUjAsW+ZHe95uq8t1qwd9Nm1qM8E5fAhU/YvvJtYO9YqXvaQak3Eh/0BN7G+
	 n7Jm4GwUM2HxDBjD49kR3SxrioZkt5qWVw80YwkGfHxRCs88u3AfU7l6wsT3Iq3UplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bj8oIOvi/lnWkTPHPdsw8/wbnTz5MyWHkyXyWXbRMxc=;
	b=S4VqxSQICNb0O8Ufpp4G+sRp+7KxkCfCHDig73uOvY6gEDwpLLpJmvInmw3cJqOT9ZfG
	 D2vAjYEceu9cDrLzCwGa1iNf6FdZ3uXYZl1eN/Wq5+nqtX1D5WFkvnjEkRrTyqA09kM4+
	 yx+Yk7Y3zk4AunMy8iWJi2tXVI5RDoBJwpk/4/hcieF2BS/HlqkZqqz9K06QC0HzTWmQ+
	 TItbFTbLTi/QfKDsAvDbx/TIu7sH4iKwgjZKanqiBrv7z6wgoXaALlsOJ0qAiCN5nQbYe
	 EdvyaULgcOw2sY2V4Sw8bYwnJP3PMugEw5TnQof2094pTSj3ZvnKQ5JR77eYhLY89aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixO1nhek;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F97606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 07:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F97606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixO1nhek
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3341884eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794469286; x=1795074086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bj8oIOvi/lnWkTPHPdsw8/wbnTz5MyWHkyXyWXbRMxc=;
        b=ixO1nhekxxalDWG1zHEJb0jw0LoiXRRtkCZWQtv7VflFG+Cib6Wh1X74S0IJjB3zx8
         Np4eNPgIUE+eioJwZQlGWpo/iiRjTQz/8EYuFQraeRzjVaApRPFku3F+vzl35LKFPKJi
         GpxGzM0aLgpIBhIeGxorOTSaNwv34fXIeU9pjlrLr//YxyFFSIZubaC0lFF2jdN+wqk/
         3SAKHwoIvuRt+VN+3IhadgJ2b+iQicFYyDXRnfNa6ZhQfMmZv25YJ3qyMnJbrVs0UkVk
         DuH97m49qr9h0DNUpUhBJmT/ZHvJO+gaVYOo7eCOa02f5mw5WIYE+BckK7AQa5lGF3mt
         pBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794469286; x=1795074086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bj8oIOvi/lnWkTPHPdsw8/wbnTz5MyWHkyXyWXbRMxc=;
        b=srdvGXT+qKkG1oI398qwycIWZ38Cas+Dd3C3wk5B+CRTLu40Mr39dp9unk9a+CKMde
         xMQTjF7oIORnIJ4e4JqQ4oY7BatfoN1JCMZb28tdtNdPpWVddT7x8h5ab3zGH6Xb5j1m
         nLLwz2M0Maa3WP3R/FYlGHanBhwrupe6/tggoNzbdRBuVL31TI010uahSo1iyDvO29Ux
         Ar75+AKxAqoGmrreFmMbphMaVsDu+C5T/gwr4J4URAdFdagTHs3ZKZf6srEZwDWkZXxZ
         yAmrZLXJlakTszGGhaKlvWY/24FYmeDX3CpllolHpGtI7BhAHBR1pDsuyB8V5Lr+JQ8c
         i3Kw==
X-Forwarded-Encrypted: i=1; AL+hErH379ETpq1KRZexjEyeHYU4Gi3JFJcxLPSvzwy9wsysiPSeJv6cL7I0VJPQUWQpRvSK64gyeI4/uSuBNvti@vger.kernel.org
X-Gm-Message-State: APuU4Z94a0EqERsQUVrWjURujOcEXsTxGu3xkMS14iu0+ffsM6hutjge
	n6mJPN5jqIy+v7wxkSrQKUVUBlzBlHc+p9D2dRbwcb6FEY5soRPGGN0Y
X-Gm-Gg: AYBFou0wFrH5GdT6j6XGBjDvnJxIlY4QczM0aXL8s5ziYp0A2t55XeYBeNXvw/L0Lcl
	ONatWTSry+x4s2BrLBdICFQSvIuIwZEVrdrlkGR7PN68N5+DKKmI6LBM9HFOLemOkiMTUa1eIVf
	OnuQbOTJUeulEelqU3XY6I8BqDjiP2SF8+SuqZoeMsoSNej9smut0nUOSpYFXSAq4MOEbEeqyu1
	kl69WJWGv0nU6BsWxN5oaKMvAQMxqJ8JgigugQCD8UA7zWikbt0H7/jn3dyihKvflYq1canFt89
	8SPUjCbO4fDsDFK7DlU7N8Vy7mdrVBnd+34ra5hK2ozAfekPLsMXyWii/6QoQP1nQ30jQQ3l7XD
	idbe76X31mneUve2/+Rmm3aSu1KOtt6DUfye0/vGlS5oivVsrFimjWNxaspI4pK0Z8tNSEbPSjK
	j5WgIX5rQhhggvb+6pEB2/2pAhbdRwej91EzGA8KcWjWuHWhoCOUHBYJnrML/ld8YhPoIwjZ7pK
	OE4LtBoumN1IxZJ28yqAzGDKaGv6ysTvqEzCfqobM8aBFuXFDAfCx8wu/vL3blw9WDtiuGHxkiP
	h6RHBCRx8ejIS2srPYlOVVKyBg2WsVURzeNOE7B8VKT4Lw7t6B9WDbRT1JXdBo2/mA==
X-Received: by 2002:a05:693c:2582:b0:378:314:4042 with SMTP id 5a478bee46e88-37803144bbdmr1486709eec.14.1794469285344;
        Wed, 11 Nov 2026 23:41:25 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9d78sm25594848eec.25.2026.11.11.23.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:41:24 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] ntfs: convert a named $DATA stream safely when making room in a record
Date: Thu, 12 Nov 2026 13:10:55 +0530
Message-ID: <20261112074055.1876311-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
References: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
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

Hi Namjae,

-EAGAIN must not leave ntfs_resident_attr_resize(). The callers return
it as is, so a normal blocking write() or setxattr() would get EAGAIN
for a "would block" that never was, and index.c already uses -EAGAIN
internally as its "redo the insert" code (ntfs_ib_insert() ->
resplit), so a stray one from ntfs_attr_truncate() could be taken for
that.

-ENOSPC is what this function already returns when the attribute does
not fit and cannot be made non-resident, so callers already pass it up
as a normal error.
It is not exactly true here, it is a short lived "busy" and not a full
record, but there is no way to wait for folio 0 at that point without
the deadlock (the reader holds it and waits for mrec_lock), and no
errno fits better. I can use -EBUSY or add a comment saying so if you
prefer.

Thanks,
Wahid
