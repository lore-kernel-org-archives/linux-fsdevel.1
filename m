Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD286372EF5
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170965; cv=none; b=A5TCcmEfwZ+PcoTpzkYPP9JW59xSfDStUuBOjfgIeXRiUYL04CvjPNTE6v3OrQYOrnhLgnma4VsFqJT0w2i/cXezgcTYf0BacRu4P0pQP4mp8CpR+SRc6F5t1iYf7TKG1Zh1pwwvXvQ7KC4kCIzm4YOiF0K4Ugdi0UrKbXdn8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170965; c=relaxed/simple;
	bh=LJV30kQ3AhVA19Qy4NIYzlbllUic9lnXc34rf+8lBzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKA+7Kp+lQXuk5UC96rSMFBKWtgBZnq1DPdoQsdgwuZbCXop5lUDYicIWDH/CJjLbG72hhnPhWKOcLyKrlgmGVBYIQwXURdZgNknmjoEEAa5UkHGi84r2g7+f2vYR+Fu75VTAHxIo6g0/xbQQUTAPfGlvXsLXhcxg8TC90b2+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJYoXcNO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJYoXcNO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso498019a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170963; x=1790775763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW9r7iNqfIgerNjHvG5s0sL/lw15LFmmpUDkujs3h4w=;
        b=YJYoXcNO9tam3m+wEIriMKQpqKt5QN1zYYQm3yl0F49YbafC7pU+Lc8A+IzBTeIrBP
         kyPPzyB9Xt73wY0pxyOCZukMd5P02+1c2xhvp9P7/KyUEXLLs60FL1sBMjvJW88RzUSU
         /JOqyE+qrIoSk13zl8NCbIpsPSMKfAvuabgiNQ/EGvoWyRLmLgYFJAy0oiXEqKj4vFHO
         3XmdcV4+CT/FS8NjwugQOsf5cK9rTbVCRmSa7+xZslmWMvJvynzKP3+j8Ff49ZvMU87r
         vxOgHhw6s74CG3jZt9pEZI0cKWiEiHIdX1pPCrQ09w7L5o8komj3mBkem0MIao+KlvlB
         xbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170963; x=1790775763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iW9r7iNqfIgerNjHvG5s0sL/lw15LFmmpUDkujs3h4w=;
        b=n7e/aOGe/q3lneDWfHubioRfnEnIncw7hs1x/NLxzVQo44Yhl0iGluPTTKGOIXG7fp
         iMUf77ugz8HMIQd0Lvm3Z10p+8Bwq+EILOyhtYsWSwo45kDMgoCCmWovFuwbitPSUBMM
         zbyoAz01xmcXGampZes1OEaK73u4MWZw4KieirAhbNgxM7/RC+eexZdOSzvwHhm4nBcD
         hkLio1gY7jRN/ZQWXwFT6kNvZ3qA1BUhl/1JGKM93xujmWZAfEc4UGblWEDlbf9pH/WD
         I1NSsHJDyOBI3gYLWcPNUWSGT7a9VxNnGDsG4F9cEXpfm3acqLz+dMWKOnZQa3+wzbgu
         GEkA==
X-Forwarded-Encrypted: i=1; AKwUvBwlvkCrHHTmWJ3WiHHaU9VONbNggvaM+1ERrdA9DzpHHn7DyFLNGtNrF5fybNvspbL2tBE35ya9WJu3+NaL@vger.kernel.org
X-Gm-Message-State: AFuF++klWXt04Bw5AP2xFmYMUgqK0Twylr7HNlcrXWe+Mvmhv4LKDCRe
	F5PDGUnyPTAycqHqeE/bQ2X0e503cYP2WdRdccbxwzbf1P7lcBcQvp1n
X-Gm-Gg: AYBFou3ojROOcTeJlenjOoAwpA6f5wSR3kiHsQb5rhCIhAO/YPoodsCi5ty2nPfYlVi
	os4QsekSkmz9m36BjratVw4GV1vsBBVan2VlCz6r+cwcLKndd3Q6CKXjpLcPFQO/YOWT4QA3vxs
	sPFbsZuUpVEKkVXud74tZJTFXdc9powo+9EGxhpV1wJ+cixQ6ZbW6DZ2BnfzmQ1jM+64+frgny0
	0jb6rLPyED1S/2MxsJL1SPJt8tE0TtpCIkNxw8Gg46ixCMG9uS/6XklkZHrgCYVpgw4dB2c0tsA
	pdiwIcmKi8q3Mmv0Kv1Xm4h7pKaYwLCzk0IMp7u6KpQYEZj0/1bqOMtRhBc4d0Cu9n6d+kf/a0Z
	tudLK0XSVuDn/dnU2D4cUXrASTEk1wxdwsyWa/U/4UsxqPV5oZV1zqWIlQcfK2vR0ygLgXgbLf0
	N/D02KTqms4pQ2RX8UcfVp3aChfszn371ZDx6OC32rzKSB3rQFOCW436Kk9cAUfb1RD8b/bgRfo
	2x2cOxYN9k=
X-Received: by 2002:a17:90b:3d8e:b0:39e:194b:fb2b with SMTP id 98e67ed59e1d1-3a07e51d0f1mr2640854a91.22.1790170962777;
        Wed, 23 Sep 2026 06:42:42 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a089197169sm2966570a91.8.2026.09.23.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:42:42 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	kees@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] time/jiffies: Saturate in mult_hz() instead of wrapping
Date: Wed, 23 Sep 2026 21:42:36 +0800
Message-ID: <20260923134237.3628505-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <pu5kcrhze4f2wz5fk2miocxx5edgmj4tp2zwcv3bpeo46vo47f@siezjqbxiuk2>
References: <20260922031229.2300283-3-zhanxusheng@xiaomi.com> <pu5kcrhze4f2wz5fk2miocxx5edgmj4tp2zwcv3bpeo46vo47f@siezjqbxiuk2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 02:27:56PM +0200, Joel Granados wrote:
> Not sure what the difference is but this is the result on my test
> system.
>
>   #  echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
>   -bash: echo: write error: Invalid argument
>   # cat /proc/sys/net/ipv4/tcp_keepalive_time
>   7200
>
> I tested v7.3-rc4. What is your base and did you modify any other sysctl
> before you ran this?

CONFIG_HZ.  My changelog gave a bare number without saying that, sorry.

The value has to exceed ULONG_MAX / HZ for the product to wrap, so it is
HZ specific.  I tested with CONFIG_HZ=1000, where the first wrapping
input is 18446744073709552.  At any lower HZ that same value does not
wrap, the real product exceeds INT_MAX, and proc_int_u2k_conv_uop()
rejects it - which is the EINVAL you saw.  No other sysctl was touched.

	HZ    ULONG_MAX / HZ         first wrapping input   wraps to
	100   184467440737095516     184467440737095517     84
	250   73786976294838206      73786976294838207      134
	300   61489146912365172      61489146912365173      284
	1000  18446744073709551      18446744073709552      384

Measured on v7.3-rc4 with CONFIG_HZ=250, unpatched:

  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838206 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838207 > /proc/sys/net/ipv4/tcp_keepalive_time
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  0

One below the threshold is rejected, the one at it is stored as 134
jiffies.  With the patch, same build:

  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838206 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # echo 73786976294838207 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200

tcp_fin_timeout behaves the same.  Legitimate values are unaffected:
7200 reads back as 7200 either way.

I will respin with the threshold written as ULONG_MAX / HZ and the
example labelled with its HZ.
