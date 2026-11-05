Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892239;
	b=LyrEC1n4hwEt82XEivvHS4moZFNs32PA76NGXy8W3WH5lp3CL9z4aNhJCP6fhbh2LG9z
	 WV0hoGkrJ9hoRwXPBigHInSldiBY8YUkHS0get6QYYXZ5NgQ+bf3TNm+M2thSkITQwRNj
	 /9IGqvqsMPUFb86tX64yo2Yz6QbucwiOKkFzIldbRGSG5Taj4N0mN6/7QvobvHZT2WSx4
	 b5DL5TK2h7fUR5KzQo3BHgDmAfuUZk9YZVkTAgaC+TLoio5UttHjx/FAKmiO5EvyOlw9O
	 VLf0+l/sVk/wsj0mOBtIz78e1rH7GGyYzTaCiEjXBGyi6MXoCAu9KhPwrC3/ebUquog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=UNhgRqz9zBhtBnU+8XawzxvpxSy1UN2gEvH030GM0ys=;
	b=xFMYHqQEmJNPhGuLsnDN8d+zpNrB37KNueFomOFgGP3OpiuFWh00pflNvGck0DkhJOnG
	 Z61hoiqu5QAWz4RJzEoCkx3hdnSXqZwwVH42lIIuXeoIjMxFh8x4Lu9ieAWr0JG9WroYV
	 r4ob5c+uFOw7SGl8+otlX7NaekP2lrR07jRO92/hKwXSeShBDI0IYxj9Ne8px2kpY1YaV
	 GOdUODk525AHkkwFw1xpw6/ju07EvxpKy3bnAH6kEjabx5Sfh/PAgDXfd16c3ZL8hAe0+
	 MwtEDCZ2+yQLmzsiHpPwcAcF2II7/khnBq6MTFt72RB5AiAmr1ldf0V0TlJM8fCglPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxb9tgal;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F1606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5F1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxb9tgal
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4ad4072943dso625280fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892238; x=1794497038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNhgRqz9zBhtBnU+8XawzxvpxSy1UN2gEvH030GM0ys=;
        b=hxb9tgalD25gfP6CVq4fs63HIuR0c0KbZPiAOgCqkbQZX1IPSyQsnsJgaipfuqWUNn
         WAvk6//Z6gwChVAvFbVTt3ehZ5NMi3X1Y0ZzrHULO5bwkrabU007ZjRUBy20oIJG5CzL
         UWm0ugMD0/UjHEBulrAGjtmepzv9RvJx8ia2EyBfW5al6Q7pepMH8ZE9gqJYoOPysPDi
         mMAA2zT23gmioCfJcXE+d2bWYeQ4MsGHyF/qi+z5uJpFkKvMMuD7ji0RnXPlMQJoVtFF
         Emmm4JaL/n0oCBcL4H4o6Fh6VNmmYyRw20Au1DrGWC/kYgt946ehbsp65Y5qGg0llord
         3yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892238; x=1794497038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNhgRqz9zBhtBnU+8XawzxvpxSy1UN2gEvH030GM0ys=;
        b=DqD7XUdD8L0ApehKSeDZB+h8Em0HTeBmuG/wSckr2Be3k0Fh8wVdoB0kYoNJqvkMiZ
         e+U8dAR0OHdxwNYTbhGCHM9PIYNMuPsZTJ0mqknqYRay3DtSVb+NDfpg9Kpfa8JkcoCi
         voDf2RChsywaraVex3CFTOHsLQTdTJBwCj81otRUUNOG/YifkYF0Nz8FwXDNdlGhVJ0g
         v4i7NjPz5CMWjyhUK7VFHgxBvQCWFK11YweNQgWOMAi1AteYnQCZfpaQRQsT9hmtRIl2
         abZC7YZFppSHFd92jrXd6iTfnQGppCAxf2zGUfoyV1dG9sFl7poJ7Lrx8KuWUml2CPd6
         l6cA==
X-Gm-Message-State: APuU4Z9P7bxQewn1gqcAA43+BzW51vclpEVVsiUqtZi+tZ/wff72rLD0
	CMXViWTMt0b5kPZYyCp3/B5pSU2gpD2Z2hJ0AajJkjeZ/fPefyHufPQdBL/RfI4iYnc=
X-Gm-Gg: AYBFou1fSLIHFQtVEmX1VwzFOc+DAq4FD1+ZOnY6J6fLBE/OW7vxgvzfgQRWp+kBFVL
	R80TyUSDTifp+K9yrNMyHQpW0K32/Has04E5YNg5ayFjai1BeflrdAqzlbr1uAuAs7E6T8C2Fap
	67Z4fxTQa2cessHZWy6XU5E3hgo7NUoezSuGtLFTsJcyYv0xPYT+AtSRXqDWNAvM40lxkBMd/3O
	faENs3G/oiHb0kBhwKGg1jZ5JFQVZGoeDyGC1Cima2xMrhNlB4N60B7cg4tf5SKfGvN/kRTO8cN
	g1yHqFUdClr/MKLGxmi+FrrIMeNzm4Y2pcShbIMF/nMUO+tulAQFb/YgFIAtmY6qy5ZPnOWZTDS
	r+R97yEql6vq7TQ2N89mjhbO+4EHDQA994PKLkZok9GnrLkthN00WZz0sta6bgLC5sigMV5nTie
	mc5HDtUiNIm8JfnHLnNldxpdEeU4sVu08MJ6NEXItpLOMpKVVZDt9KyNAgF3JdL4gRTo3xzwlGH
	tnJsMasYHxmyB21H1dX3xtacBEBa37FApANX+UIaYd138DHuFfUDalS1Un6p7PuCdQS0FYUGC5X
	Vx1qgTjlLYxWmV74W7V3vC1KwT9PrfO4ESjiSZm+nEPi
X-Received: by 2002:a05:6870:f623:b0:49d:d220:e234 with SMTP id 586e51a60fabf-4a90770fb5fmr12484357fac.35.1793892237891;
        Thu, 05 Nov 2026 07:23:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea48fd55sm4929307fac.4.2026.11.05.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:23:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:56 +0000
Subject: [PATCH RFC v3 64/90] cells: add the "caps" slot
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
Message-Id: <20261105-b4-cells-v3-64-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=3699;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yhopv4p9Qv5aSxqkvolwlmRaUHEIceXqiSVnH82EndA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHNk1fZtucJ9cJajDPxHPodvTs2pBeAUzZVRa1DK03U6pa+mHvNo31+66NwasbIOOPV+dk5TgJU
 U0l6Nr1DuiAg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The first task in a new user namespace has every capability, over
everything that the namespace owns. That puts a large amount of code that
was written for root within reach of every user. A container runtime then
spends its time taking most of those capabilities away again.

A cell only has what it is given, so start from the other end. Being uid 0
in a cell comes with no privilege. It is one id out of 65536. It cannot
switch to another id, give a file away, or signal a task that runs under
another id.

Let the builder name the capabilities that the tasks of the cell have. The
"caps" slot takes a __u64 with one bit per capability. An empty slot means
none.

The value is used as the bounding set as well as the initial permitted and
effective sets, so nothing in the cell can ever have more. Every task of a
cell has no_new_privs, so it gains nothing from a file, or from being uid
0 when it runs one. And no task of a cell can create a user namespace to
get a full set in.

Filling the slot requires no privilege. The capabilities apply to the user
namespace of the cell, so they cover its ids, its tasks and whatever else
that namespace owns. That is no more than anybody gets from
unshare(CLONE_NEWUSER).

CAP_SETFCAP is refused, because nothing that a cell writes may confer
privilege.

A task of a cell with a single id is not uid 0 in the cell, so it would
lose its capabilities as soon as it runs a program. The seal refuses
capabilities for such a cell instead of letting them disappear silently.

For reference: systemd 255 boots in a cell without any capability and runs
units that stay root. To run units as other users, give files and cgroups
to those users, and stop the units again, it needs CAP_SETUID, CAP_SETGID,
CAP_CHOWN, CAP_FOWNER, CAP_DAC_OVERRIDE and CAP_KILL.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/slots.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index 0a406422ce34..a96d2f262aa1 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -105,6 +105,28 @@ static int cell_set_ids_binary(struct cell *cell, const void __user *uvalue,
 	return cell_set_ids(cell, count);
 }
 
+/*
+ * The capabilities that the tasks of the cell start with, and can never have more
+ * than. They are over the user namespace of the cell, so they are good for what
+ * that owns and for the ids of the cell, which is why naming them takes nothing.
+ */
+static int cell_set_caps(struct cell *cell, const void __user *uvalue, size_t len)
+{
+	u64 caps;
+
+	if (len != sizeof(caps))
+		return -EINVAL;
+	if (copy_from_user(&caps, uvalue, sizeof(caps)))
+		return -EFAULT;
+	if (caps & ~CAP_VALID_MASK)
+		return -EINVAL;
+	/* Nothing a cell writes imparts privilege, so it writes no file capability. */
+	if (caps & BIT_ULL(CAP_SETFCAP))
+		return -EINVAL;
+	cell->caps.val = caps;
+	return 0;
+}
+
 static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
@@ -117,6 +139,8 @@ static int cell_set_binary(struct cell *cell, const char *key,
 {
 	if (!strcmp(key, "ids"))
 		return cell_set_ids_binary(cell, uvalue, len);
+	if (!strcmp(key, "caps"))
+		return cell_set_caps(cell, uvalue, len);
 	return -EINVAL;
 }
 
@@ -163,6 +187,9 @@ static int cell_seal(struct cell *cell)
 		if (ret)
 			return ret;
 	}
+	/* Who is not uid 0 loses them as soon as it runs a program. */
+	if (cell->ids_count == 1 && !cap_isclear(cell->caps))
+		return -EINVAL;
 	ret = cell_make_pid_ns(cell);
 	if (ret)
 		return ret;

-- 
2.55.0

