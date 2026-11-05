Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891363;
	b=raT2UTo2pC8UNsTwvyyZzfq7XIer0sJGUC8eJqTwRuHbYVpyanvTC25p/WAEWOZ+PRPO
	 gVpik0Bu+yuFyLXesJZjQ+v70Gu+yUE2w1nFdyDJbqDoo8J4yFdB9h5aDpWim5o5VIRiz
	 6f7ZoOjt+VtXrqaSM5Z4LtliLcjC/dLrlphW4tUHiLJk7XLleLTHadFztPPzi+pqekwIi
	 rdfFGvVVpInZ6jcvtJlUmt3VeMbsDwrACj1lFZSqzu3epswnslomWS4RRO5hV6oZGyG6s
	 OwuzHxwfRVQy9wHBcQ+Fhs9MBVNQZX97Ocivnl9Udq8uExfMlAKe8gFtgBwqb7j5Yow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NdBlg6gYq5FYgjcrPv2VAOO7NpyllcS1uRLuU2fZQxA=;
	b=b6J/6p25kvLHsUUwyUKnIU8u42KZOXXr4Yr8aTRCXoT9P5F9z19gkWp7PsKk7xcJBIQ4
	 8Dy5qlxUomc4OQxMTlmIBpZK71/cwOtBOtigfF7/6+8Yxfya6a0yolvncwtD4k/1IF5qL
	 GyPQcJseZxqvCjwzcFggqie29pQqqQceS7rsCJNDlmsK49gZBQgsGoR5GrkDVi+kIDzRa
	 3z0fBv6K+hyB1Jyn0Mujw8u3BdP5urkIzXrfXeTpE2y4wIgkmyZtUFp1aGqLpbfFue2a6
	 L+DDZ9rDabP3CwSNf5t/LpETXjGFYRzpIbANcvjyF9oRcbDbjyi8Rx3E7Trtp6kQMOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mtupoV8f;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268A606A336
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4268A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mtupoV8f
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0a921ee46so19458677b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891362; x=1794496162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdBlg6gYq5FYgjcrPv2VAOO7NpyllcS1uRLuU2fZQxA=;
        b=mtupoV8fsI+wgT5AauHwN5cm8oLGofMq6yaUQ3wbTjAlhd5ywLU0xddjZ3u42T0kgm
         7OMGDeaRJ2QNxSQxWSl10ehyTgBnKBXLxv11hVwUn9xB4xN7CaVoisBU7/gUxPH+OSDB
         P0kabKHguZUoQueQbonMYxbnOJsIQtNy5piVD5eS7DWc6a771vKHhRN935e+qb0YW3T+
         pjWUDB+Kzlt1RvWWJ6oxrTkqWorVRsZz9WzWj0RTxbFreD8XJinzvMMXA0Rt92+tt1pQ
         HUu/8oPaktJuApfcJ8ijMKcfBZi01KxP4ZAbzEd/nfV4/AQaMvblraEAwwzu7GOn4Wrt
         wtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891362; x=1794496162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdBlg6gYq5FYgjcrPv2VAOO7NpyllcS1uRLuU2fZQxA=;
        b=jldXz5U4B1sRIqBw62vKEXFxD0fUrOsrMT4XJtfn1u7KSeyuPoZ7vvbLf3ehYS6Eex
         a6EYRd5gGiMtW5edi2PfX7NjwAnyqzIoXhdgy3WsFNMeX5XoQiC+q/oYUMkzsSs8ur2Z
         VOMX0UCl8uuqTt+AXc3r7ENcvGmRJ6z5FJIGnBy7+easQRiGn7AvserCUeyj7r1tk3qQ
         NmbBtmAff0ukdLtnABxqTbZvX64S2bBdFt71kkcq4sx2ACp3S4iS3vIcc+P+VGpzHyVM
         EKQFOGAJIKcit1fnYK338SBCjD0Y1q04rsHF3zC4Bgq3+5wdXbeFZuxnGb9vTLpeR1D8
         3f8w==
X-Gm-Message-State: APuU4Z/GaroPh4g7Ja7A57Zd9Pw5P29J0pr3CYIiEWezVSGOkbDAPp+F
	xzNAjENPI124Xfjf/07j83Yn6N77WL3iQBd9/zGeZJr3leov50pd//8esaK5yPAHfl8=
X-Gm-Gg: AYBFou12g0TJtsSjn53AGLeWaglLwhHhNkLAvP/1VnaM8uRgmavkDqKLuKV4eH7ll9X
	izmVMeawAo0nNFrLoiqIugCXz1rFcd00YnkKk5T9TTwnUETyN6FMvvSa/KMetL7heKCI6nI0VgD
	VAuiwf/RfDEq3plibBWoKPbwbp9M0nJ21H2Z7pn9inF7JsjZ2vvCmQjcVfxHuuZXB3CaDH1bfBD
	FTR4hDtiYufwszsw6Nu076uRkNy7qmpRqgocI3rmehP9bIIhYczh3n4nFE0jO6Vs+RIbdWCYell
	2pV9u1BYTZX+Gqb5e3auHnqbGZDFMUIwiy8BxKO3ZbFyVPciB/7nSKeRI0CDnsXJk54fiB0kXqX
	nbPr4XUjBwuyru9Hw/igBCbJyQYMpFYM7Y5oiCSxkUslJKlKl050YC9qqjNES/XgyoPFV0vju0z
	PNZknRRxhGpU2vb2SzHZoMOEb6pZ5zBNgnBwEcrm0jLxU5cjxmNuFaoyucFoblUIYrkyg1Ik8/s
	jSONl4FVBqp1EBte9kumE6AWnq+Z3jUBDpeEHUw8/Gb3NUzhVh1F1SX/ul0oiutndpBXicsqBU0
	TTba2gsA+b7qHCQpqhuJuWoC42CzmZG8foGtud1X157tTQ==
X-Received: by 2002:a05:690c:f82:b0:8b3:2eb4:1423 with SMTP id 00721157ae682-8b32eb41a18mr8941597b3.25.1793891357471;
        Thu, 05 Nov 2026 07:09:17 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b32f0f9631sm12195477b3.36.2026.11.05.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:17 +0000
Subject: [PATCH RFC v3 25/90] cells: add cell_kill()
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
Message-Id: <20261105-b4-cells-v3-25-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=1887;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=5JqCVnXo+nzIia4E3k6kZfSHS0ksAk+mWBsP6JoVIn4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKM4qPz8cvz9J28cjtlEHW2fyVlbs8kjfbTCGKh0F/nQJkD4VSuLMpzbTc/K14cYHUTqimw3XJT
 TtPEig+lyiQQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

cell_kill() kills a cell and everything in it, in whatever state the cell
is. A cell that has not run anything yet is torn down immediately.
Otherwise every task in the budget is killed, and the teardown happens
when the init of the cell exits. cell_kill() does not wait for that. The
cellfd becomes readable once the cell is dead.

This is a separate system call rather than a command of cell_configure(),
which only applies to a cell that is being built. It also means that a
seccomp filter can allow or deny killing by system call number, the same
way cell_info() separates looking from changing.

Holding the cellfd is the only requirement.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/cell/core.c b/kernel/cell/core.c
index d0243779af19..b9494b5fd7b9 100644
--- a/kernel/cell/core.c
+++ b/kernel/cell/core.c
@@ -310,3 +310,31 @@ SYSCALL_DEFINE2(cell_create, int, parent, unsigned int, flags)
 	cell_put(cell);
 	return ret;
 }
+
+/**
+ * sys_cell_kill - kill a cell and everything in it
+ * @cfd:   the cell, in whatever state
+ * @flags: none yet, must be 0
+ *
+ * Kills every task in the budget. A cell that has run nothing yet is torn down
+ * on the spot. For one that has, that is for the exit of its init to set off, so
+ * this does not wait: the cellfd polls readable once the cell is dead. Killing a
+ * cell that is dying or dead already changes nothing.
+ *
+ * Return: 0, -EINVAL for a flag or a file that is no cellfd, -EBADF.
+ */
+SYSCALL_DEFINE2(cell_kill, int, cfd, unsigned int, flags)
+{
+	struct cell *cell;
+
+	if (flags)
+		return -EINVAL;
+
+	CLASS(fd, f)(cfd);
+	cell = cell_from_fd(&f);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	cell_kill(cell);
+	return 0;
+}

-- 
2.55.0

