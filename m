Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833D397694
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224313; cv=none; b=R1eGdCSyRXISaTbpyjuu4QRwgzj91h2KjyFP6dPAXMGfdMaO634r1TxW/Lz5xZf/l9ldlxcZGS09Ic4rIWMEjwiYlMq7tFCD0F3cY8DTZW53xLb+5oDcLob3j63JdwmRCRK8t3avjqxkHLwVNG1kfhZ1miIfow2V0tvn5V50mAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224313; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C51+KH9gQ7StCi1aHWD1MW/7YfuOE9oKyi0DZxSs3R9hFs5QrhKQsGJgWSLsRaPJnqEVOVCFwwxUiV+KkV7rUQXeD2eNfdRCbr1iuUnAcoNuqc+zLD59/3Nef7It0u0GVcZu0gv1ViBiIqg00dc51VQPuid2sdhiKH8owJ3cpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGMKEW1o; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGMKEW1o"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c4so1260453b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224311; x=1790829111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=KGMKEW1orZvBY4yw+WOCDo7fvXIDazj7Xjhu/dAb4swk0MDdpUQKXAX1ZdP+epMayb
         mj5dle/aTGZ4fCpry0AZXNp4Bk1R3Xs/7tyuzkii672jvgnjYorfkDxrgeFZvUqcvIdD
         zaUauQdwUYbLpJ9CL64Dsg8UDo1Xp7m3pbjuqRfTZyYrZB5mFDKzXSssB0QPFEnXEyNz
         iHgf+TXoOdMTKVd8yp2d/gtDTXzriUBuxOzhrHHRRamIgT6q9NJ9YUe/Gz5QDDshmNWV
         0dzxI6KsWpCqyU746qAJobnmOwagHDOKX57krgsnZhY7ODOJGjFyksDoWtVCjeEqL5km
         d+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224311; x=1790829111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=ZBg7EAcE2+WI5eOybW+KgPOnw8B3Br0PoECPYRv6Aw6iK6bMNxBpi49Zh3+paFS1PO
         d7VpRJo8PGn+K8ZjRled1sR2sv9saE59sE8VR2pHrsAi8OBe/CQ2C6kr4IJ25eg4XpLJ
         p4AKysOmAEgyo0sQqtAlycXspCOHyu1MDWNgfwcAb2akmHJbPfllEHqZgtBtIu+dx8ye
         33jvw0BIi3I7o1zXx+4n6swaRangqYHtEkHJ5zqvUgEFv9vLOj/b7K8h5oXN0heIJ9AT
         ANvpf6IJxErYrWDoeYi4bz+TvV3srg0wGwnD46rSwhSy9JGeSFEA+gm5PuwoIyTdd3wM
         D/GA==
X-Forwarded-Encrypted: i=1; AKwUvBwWiVuvp+aYr5WTER62bs3J7bSQMLCkhd0IvWXlgrHuIlg4+c3haA+WWaNcQ8x4Mhht9lXD3sbBa5FkNMeS@vger.kernel.org
X-Gm-Message-State: AFuF++nvMfGFCjY48V+KcqL38FZAaitQ5Av16smnJ1Tz3xIJ2BXOmIdm
	Su+KwwdHKpQpFPxVvP0/z3bWZe+IEUn7LZdsyAjoxxXjQ+jEWG78c1tw
X-Gm-Gg: AYBFou03+uKk/RjU7UFilXUrdlRhfa3GFwwE9HYWqdkC+MWP0EJpVqH6iKnx6Q/zydK
	njnzaCcFju2U8WuQmhuhQYo2WQ72uEziLMqJQq0tceu486eZ5TJ3f980ZVWMUVF1V8Ovxa2Vdrw
	2e8rAM3St6/NGIClDE5lcg8krAPD/AJCFuXdMzBeAxb5n2a40bMblKag6xxoflzlfsCAzrw/hFV
	7C08rtT7Y0MuUMQPyu5U0TprzoX4DK0fYx5hfQVYztociG2GGZV8fRVDc/WTZJ/zZQ6GIHn+Ptw
	RiuZCTh2J9is6LvlwfacdV96b4vJRbBWZue/bjLw9fpmAId2B/FPAkqg9cCvv6yQGKxfuU/10+P
	rXlqMYT5XHk1BaZLW0WB1GZPVx1zKWefAyhr9aMkaUg3NhDfkloy6+loGvKZzfxLOcMR9tOWwGx
	QbH0cO5Ch5rQlH2n2ymg1PgnpyP7DG8YkPVi5PX1K6WzDHaG5301pcUIfl6OklBT9MQfYsHkOGb
	2twBrLfa/BIhf+45P4mjTYHKnPTHp93YTnekQUM/fRFOFQYzXVuy7gYZvXjvvqg5KChXgAC+ZxW
	4ZcIVgg5MUZKVVEUuRnpTC+90DUfkM6KrlJmuoQjoGMnvmGCQo9B+mDAyX1dLE2eSUmA5A==
X-Received: by 2002:a05:6a00:398b:b0:878:34d7:6a2c with SMTP id d2e1a72fcca58-87e9c069ab3mr997440b3a.46.1790224311140;
        Wed, 23 Sep 2026 21:31:51 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c12besm2165286b3a.29.2026.09.23.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:50 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] qnx6: release sb_buf on mmi_fs error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 12:31:47 +0800
Message-ID: <20260924043147.3896456-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-4-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-4-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
