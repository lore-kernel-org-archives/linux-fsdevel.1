Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891426;
	b=u5WloHsOiAkcNf1wbSjZ6UO3NzAgLil1mSuE+CEDCHNBhPLtofYwmg4yixsXojw1gPNH
	 yNxR5R4EZudBM90Fvhi/S9BTjjhJ28oRtm1wjtLbY09NsHqQoumzQLvNIpIlArLIiSSel
	 /it92fZrX9StJYv6X9NrVSQLUgtDNUl0Ik31R0kyyW4easWNeAkajLQkVgvWg+N/qn2Sv
	 +6/V8sos77DgKmi7vPM01foD6EjsuoGKFckyWy38pfhBMkViUaKY9LJxOtiksf8rX4h84
	 jMjmvSDpSGYfNlhNj6zaI80hCbCUYcSnHkt8EXTDzEdlennXMiIlgJ/ULtLNoWDTE2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8g0XHR/ITbhhSMgVfvFIbq3CplagOiu3oAqzJZfHPV0=;
	b=2C3DjuJ2Fnvt9/ZmajgNGFbPj9hna1D13o2SY5yQuzvoKspT42z9uRqnSECK/mvDdvLw
	 eJyg1H0V4lX/77rTyI/3ARWUDlp+ZcLV/7+9ALBVUeHZk1WCJ4tJ3ldpTEYH/pm/ocwM3
	 wwPQDDmv/SclUhEDr41/IXL0zl1uUG8HVVAsyTIUXxt3ezSc5vgCnZ2iOsfDqhC9dj8a8
	 onEWbluQPGMW49Ro0JKfo+SRVW9nA4G+V3t5vZ2GL5l5BpI5fiuEyb+pSllZ2YUjMgRIM
	 EokPVjXqZ0f2XvXapxmEpHjAuELu364zMF1p/YvG8jDfmYIjmfAT0Jx0a1NrgtQhXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=HlXGSXaR;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6339606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6339606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=HlXGSXaR
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679334baa1fso2994265d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891425; x=1794496225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8g0XHR/ITbhhSMgVfvFIbq3CplagOiu3oAqzJZfHPV0=;
        b=HlXGSXaRXHnouVNwDNxoNqqv3UML3PUm+cCAoTSvOZoqqdn4nYJ7zprTSZVmLyZXfV
         a/PZYMm6BJ5nyHxrsNjCsWdgNjiMDz29d3KWlXsUS75S3el0jqPeDS87HWmZUfe10zUJ
         jF3wzq45JmbVZLurf1+1KZwUmLy+WlUm+5mXLpDUKYg6vInbnD7uTo9e7kpGtV/93NYR
         zALj2+iJcWgx+x7xApc1gLLq3L66rWNhC5oWve1KN7cR2Lq8DuLqdjxve8UYKd4NXd5O
         2xwxWZT8UXHeAGtArBg2vEmeceiLYLYh/FQHMOkJonB3q+3G1YV9NLuJs0evYCyDii7N
         je2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891425; x=1794496225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g0XHR/ITbhhSMgVfvFIbq3CplagOiu3oAqzJZfHPV0=;
        b=JDRq04PbMpYgGwvRaLxBNyiPLDTKbFCipB3O94Zwm+K14qMMeOkuI6lqVW6LuZaBka
         7qeYeLIeV1DQoaKBx/jsxK8FcwK1hJJVZG3pyXf+MlVqF6Cp/5GmYM0YHS7FgjK9+hu2
         hfj3VyWgDnJXvvmXyt7UWeGXOdg8y1Qr5taUuQm9ofepmhm6MnCY8a78ivJOg6qVbweP
         QuRligPqVw4QBGWWANKrLB4QG/611/Xt2yh6LXBlMHCr0OU1L7FsqQJ9VGNusxZoCtev
         cETMDLy+Ov81buOYYHXjFameNQID9KZp4+U6Pa7gXyVYobWeKZ4bbWGb4NOy1LInfwa1
         2CgA==
X-Gm-Message-State: APuU4Z9XqcfrDlks5Gjyw+vEE6ClTLSJkincSKypAw2lyZwPgi6GDBQg
	xFrmDho0r/rayWqukOV0aoERuhGUonHCQNaHfANJU5ba6vrScTrq6bDckXUKs6eoBvQ=
X-Gm-Gg: AYBFou08vKkdTvnHK8E14f7Pfg0rG7Pb7AzLMBorE2deQlZNVP2gDrQ0MzUXfSjAkc2
	dYbF+J1Mzy/9p1lJwTgTsEn9rnjJFocxwUx8XG6cGvjqapKCGhcZAyYEy7zFx0nXpJf0Z+y497D
	YY+l03y83zuYcZAt69eB/SjmZj32sYzRWppXm1Tdm71xuoi7n6gzH55wx1xi+8oQWrOzAEZ6Ut4
	BdabR9kE7n7XSdKK6zmlChA/miz9NFOy3fAaR4SxQqAbWWuIDn4eoCM761JzK5NogyTptnZmZGe
	uC1o4KbMHSd3cpNCyE1uTP/GQQkbp4wJHlnAbDUBG/usmR3xEgPmY8hXjUqXGagRqCjTAADktHK
	DQMpcHhlgxE6Mj2BGXWzDOJtdhwXEVVReLSeP3lCXj8bAeypbZJEto+nN5+4DiEVjg0/nl7I7af
	yI9stY/lzClVST5a4MhoAPuiYsdt11PqIYj7kk0J8zrhnckUH8sk4mFJAdEcHJlofgCa+i7q3Qs
	Q/XFgXOvLIx/ZxwBjCi+A0ndgpoo8BskkcH2VTPZPvH6b6LjMrAXjQFIk2W6C1yvlE9Sw9jgpvP
	VhhBVKitZvEnbo9VDHfTwS0uFeBE2g7l/v3ffn39arPlNA==
X-Received: by 2002:a05:690e:1247:b0:67c:10f8:ae42 with SMTP id 956f58d0204a3-67c10f8aea6mr175755d50.157.1793891424738;
        Thu, 05 Nov 2026 07:10:24 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bf91b6e7dsm2786090d50.13.2026.11.05.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:10:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:20 +0000
Subject: [PATCH RFC v3 28/90] cells: add the "root" slot
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
Message-Id: <20261105-b4-cells-v3-28-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=1991;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PSE8gg+upOtVSxRUph97ujeQ57cqnyzeIjRRjO4JC5k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE8dTtZZkZ6nMq4uM+gi2MCO34vLYWaw54icrkWLiF2c4b6JzwvjvlKv+Pg6IY0sLzLN2q1Plv9
 +JSKwYW1hVQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

CELL_SET_FD with the key "root" takes a file descriptor for a mount
namespace and makes it the mount tree of the cell.

Holding a file descriptor for a namespace gives no authority over it. So
the caller needs CAP_SYS_ADMIN over the user namespace that owns the mount
namespace. That is one half of what setns() requires. The other half
concerns the namespaces of the caller, which do not change here.

Whether the mount namespace is suitable is checked later, when the cell is
sealed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/slots.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index 3f74b4640334..b3dfb32b1345 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -46,6 +46,33 @@ static int cell_set_budget(struct cell *cell, struct file *file)
 	return 0;
 }
 
+static struct ns_common *cell_ns_from_file(struct file *file, int type)
+{
+	struct ns_common *ns;
+
+	if (!proc_ns_file(file))
+		return ERR_PTR(-EINVAL);
+	ns = get_proc_ns(file_inode(file));
+	if (ns->ns_type != type)
+		return ERR_PTR(-EINVAL);
+	return ns;
+}
+
+/* A mount namespace that nobody has entered, which sealing sees to. */
+static int cell_set_root(struct cell *cell, struct file *file)
+{
+	struct ns_common *ns = cell_ns_from_file(file, CLONE_NEWNS);
+
+	if (IS_ERR(ns))
+		return PTR_ERR(ns);
+	if (cell->mnt_ns)
+		return -EBUSY;
+	if (!mnt_ns_may_claim(ns))
+		return -EPERM;
+	cell->mnt_ns = mnt_ns_get_from_common(ns);
+	return 0;
+}
+
 static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
@@ -63,6 +90,8 @@ static int cell_set_fd(struct cell *cell, const char *key, struct file *file)
 {
 	if (!strcmp(key, "budget"))
 		return cell_set_budget(cell, file);
+	if (!strcmp(key, "root"))
+		return cell_set_root(cell, file);
 	return -EINVAL;
 }
 

-- 
2.55.0

