Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293E36998A
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048015; cv=none; b=q/OVUQ7wcN8iudzAQDtCB17Op/e7buLW4nq8xeoXbn0abpB38LD6CbAH5f9sgs/GIEqp7R7kRrK2FZiaatB/LnfpCxi8LDCEMkHQD85LcJDik/fH1yHb6iEbfpptN3rIHZ8ePijRerKf6l1b2QvZY4fkSEh0DGDKCEbuUu7vWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048015; c=relaxed/simple;
	bh=bi3GXdFkUHfCUO2NRaFkiDKjIfJGzdYhOZgO1a0BYR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLTtSB8x3DODKKhRcWulclGKddlhL9t+DFwOaWN70rzf5VnY0dsLOUNgHLP+o5ZeYvNJ9pssqCQNW8FXuDQ6Ekzyi0BcJkndlUy9ZhwI4bsiDWIdqeg8Xy4gmkgKv7FPKkUzRUIc7HGVOfJCCf5xHv6T+Psf4jeTJbAd81mJ09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJAtiPQz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJAtiPQz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848643382fcso1828506b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785048014; x=1785652814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bi3GXdFkUHfCUO2NRaFkiDKjIfJGzdYhOZgO1a0BYR8=;
        b=TJAtiPQzgRrfQA+2FIID514FxddpW9SE0tcCOW2v51YRFqMlbuPXdbxOqGn7hLVJjK
         w1dkmgbep0tLDGJQmbWsbILA/XR5De9FWYu00RZIO2UazglIm6KRmSZdQIkubYxGRCt2
         CnIZIIRJ1/KCk/IZrDJJGg459gEMos3QaRE+4uH7oFPh0bLg69y4YdQSuf9LDAT6KbW9
         h54s+fmOjfdXj8oGl01hxzV8lEK+ajFPITtyicaC63966OwctpLziNAIyzzqpyplaZ0U
         U03my/fnff4R9cOenKHBr8gfQV+Y7XurgBLNWhsz0VknhfHoaSkRGBLFcJuVD+UBgw9s
         /mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048014; x=1785652814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bi3GXdFkUHfCUO2NRaFkiDKjIfJGzdYhOZgO1a0BYR8=;
        b=MJFUeTbP+AxplMUzohFLOw2K2vbm0B1PAMS0plVUbE4y/4Fg8CNqBtwzsCCedKXo8f
         DBuNCFOS34YEHnSCE3CZKGeLB4LxwAHZWmo5CN7w4BJ40L7QyLsUu6s9/WIYfhm6Goyw
         qT3JpO0pa5+3TcxXQIFb9qX6M2IcoAXSrBszm6wGCQoMQPBM5EyzJUQn8g8WUjPvV25L
         u7ztYQpte4VqLAADuJPncq5FDKwnSyWQm/pZVlVUAhithSsuLex7qfswtqE0DW/YJJP+
         QRMePwtEUXiD0g7Lu6iadMudutU4gxptfpdoYo+AbiouTJrAsv3WWO58IjaIVdzXn79P
         G8iA==
X-Gm-Message-State: AOJu0Yx1hOmp+xt9GZIrgi4Dt6o8HallCbc3TdOkeOd55j9ohz5BQlCE
	3p6aM2LEq+IlcMhoe1CNR6kxhUrWX55X0pbtaK8j1FLxDU7KfQhYR5L2gh6DooeoFZE=
X-Gm-Gg: AR+sD10Yind+12NGVtUpAgac0RkVVV2u8z/dVXAq3Hf+4JK23Wjluy6wAwPIsckwTBR
	e5q8VxQZXyhBoB5wQgDxfZVowYrmt5nZS/BU+dLkkJnfQzdk9hxPA8fFnuyroGsQnhnjU4IGqQh
	Z+qny3l75JzB/FXUnEkODJvzT+OTlKB/2YMJ98eOfvKYm6G6RMxNqxs0xv2wHzCZRBfp3eflidh
	PibWUA5lhoXDcZmMlVcLdts+Pl6XtHTAkCCQ1ORIqxsUYNmVt+HyIjxgvsH1JwDrVAPw1xdlR/s
	hIUez8gLo6+AHyXW+S9SLByTEDjUPYZUwsch4HlJ8lFvBrroC+x6x8hWUDnepDNDAmn6molT+bL
	x/GipFh0q7XuiYfAY3UwKkLjyZ43vtjIDr3XE4YIUipfcbB3m5iurh3uXy8xvStIY6ICo1/1qIF
	VT
X-Received: by 2002:a05:6a21:4a8c:b0:3c3:a969:2cf with SMTP id adf61e73a8af0-3c67e0bb04emr4007796637.53.1785048013999;
        Sat, 25 Jul 2026 23:40:13 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:50c0:1b11:5404:3b67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm26894575c88.3.2026.07.25.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:40:13 -0700 (PDT)
From: mdshahid03@gmail.com
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: hfsplus: remove redundant NULL check before kfree() 
Date: Sun, 26 Jul 2026 12:06:09 +0530
Message-ID: <20260726063939.247892-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a1f28487943ecd21a97401d7caee98e0f2eb0f10.camel@dubeyko.com>
References: <a1f28487943ecd21a97401d7caee98e0f2eb0f10.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks for letting me know.

Resending the patch as requested.

Thanks!

Mohammad Shahid

