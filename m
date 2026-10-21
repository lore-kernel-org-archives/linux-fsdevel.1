Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615081;
	b=YTnrOvF/twKq6l2iW9HD7twFKatv8uOQwPF7xfrA9jbKIXZUtXGa5Q4yEUttcvk0/D8t
	 f4SYh18wIlIabO7sfeztVW6/pj5o3ccceJtfn4db0eLLuxDL+14LxVDrFUnUPr2VraUoh
	 r4mLOoGo0/9sJB9wpOoBQn2Z+c3FMNviQbNKMT527qXLWFVNHhFRTFopivUevuRwyXvUJ
	 we5G6BRVNC+soFB40/5ppCbuMJ+hcE96zEL6Qg0LJJbsfaMcott68MK9XZ35wOy4BFsCz
	 an/DkFn539veBqiZfL3wlmTEzUeaHRMYtMSKHYMGdZZVCG5xNgzsQ1HFC8SMUNQCNpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
	b=YnfDAIBchlKZqP+akgCRntEq4Bp1Nb7gqIVxI6HiUb9FT6/SVdVLSiR/jTMjqDT+6bRE
	 VLOiowOwdbxcnXbcakYG8vLKC1dw4Bg4Vilq+CD4f5M3+ZxLTVb6HDCkSHB9FQ9R/SreV
	 ueMCNKj/ZB6XtAO4QIBPzp2k2Idu1r7iJuqDvJ8MGEUiSjXcoFcM6FycbRqUnoc35CLDt
	 3PgIPfSQLeiOootnOa8XDr1ckZrBcKlVr/1Fgplajbwe7wR/SFwiVB0OBjC8zHsmbt8w7
	 p7ScBDhX2qZ6OHKtUv6igJqd77hzMHfFu8uP+RTpm7Hy2NISv2wAbIyDwqN8OD2pBbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TJJB0lK0;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C460A260B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D76C460A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TJJB0lK0
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e6eb77f0bso101967685a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615067; x=1793219867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
        b=TJJB0lK0ppJLS7oR3UyWcCtGx90PdBJLK7d8BmBxFSaqwOSCKUu0WT+qgbBwBxinVM
         uq5Hj8rd51/hfGI3h12FWRMbVseZFui8W0rsIavs8AGgjXACyFzyGmK/vaWoZ1bDI1JJ
         k5NvQ4DK+HUFtQJqrtz/RznhGuG1wwlM79AVUt/07u750lmOa9nC14nyZGa/+RMPeH4F
         d5uANnP6SpoPhx39VaFC8u0yXG5kK/BRG9c8Jqtodx9g2wP6tOWM3m1s0cvck8Z88dz2
         J0iIB4DjCkwHFCaNxDsvhLaUNRZb44NCqs2GnrojXxFWkbCkLlzLJcz0Xt8a7sWtvh9O
         a6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615067; x=1793219867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
        b=ULmjve4WkvqsAYUxz6hdhgWP1SWlYuDRXcuPLfcPA9wfsxYKsgZpiDOXTze3o+qPWm
         H+Rshb5ObIwycDmFCWe+AyQRbbAYjlfEImcXZ0I2b0/ZVOSXhVNegiQ+8UjJ4tcDDVcD
         UxFhk2zKGEW1GJBaZpuwmS1W+0pmhmIRe0iN0JsOQz28wsyHvTgS9MC+wpA7HpKKudxn
         yltuj/BlQbNvovocN2tJoCAVgQwoveBiojXqGBsM8OWk/lil7jFcY1voLSdhKlEGZPqN
         UpfI8En6aRvJGzW/mFXBvWcv0ufxOhSZ1c9PYRkFAlqW95014lHHQh2HhFfroM6IybNd
         KClQ==
X-Forwarded-Encrypted: i=1; AKwUvByerNtZzdqo4Gc+xB7yUE/fy24Xzgk/Zj3YDlkfmvGLV7UceNe0PnLWkkhQOx+dgWibdwBDPjiULPeQfXG1@vger.kernel.org
X-Gm-Message-State: AFq9FYJgd02FHeGoIGaS0OnNCDnx5jI/C5UqIu7GvDZIw6rghxO95TQ3
	YdCqqDAF3pdF48rRhcRAc03bC4HBxs9QchlAA904uTfOBEZL+uGyy5Ul9aq/BItAdno=
X-Gm-Gg: AYBFou18klYl/Q9c/5qXxXsHMihTfeCWWtVRX31Wu8UQuAIWw/5/A9KZ2prtZmeD7uH
	4RqWCz9+Wl3MyM0+w85CP4s1u0LMfu/cxsgqLDG/DCZwdDZYzEiekvd/dNLAe2PpC7BgUl6XKne
	81Y1WUtnaEphgISaZds6K37vtVJxGE9yrURm2y2pGkPC6P118ZMWWQd8gSfoYBHl0HXe43BPaCL
	Pu7psLoGVnD6N8ov793Ok9PVtMt0EIaY6u1ZRBhmOcLTAyfLe9qb/nPN1wiawc4arrIwz8cPo4a
	y+nyUk2muqY9eY+5SstUm0jwG8bb8omoxnvmoADFikBbxGKnvznnioVIbWzG1GP/pifsMdHQaPY
	rXtVlTPdmUQ1qs5b6QFU8NbVPDF5+F7wM999Vg4F4QGolNLVz0ASR40loAUZyeF/NueoHV2eDEI
	esb8Y0G7QWMN2yEk8DIRC9JtAjcGo4/w9/tZ0pGfRaH+NyfZiMN7Fz7ERY7RlFo1DL7YZQJLWHI
	kyviWQ6Kps33L+p+judTc+2UeiG7VZTGwbJXkZwtmXypCnPbCycBn51bR6BAs4u9vWPASmm
X-Received: by 2002:a05:620a:1b9b:b0:93e:d854:4b83 with SMTP id af79cd13be357-93f57f20218mr702292685a.22.1792615066863;
        Wed, 21 Oct 2026 13:37:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c70057sm343030785a.5.2026.10.21.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:28 +0000
Subject: [PATCH v3 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
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
Message-Id: <20261021-b4-setfcap-userns-v3-4-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=3016;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wRQfv+uQ2WPQh0CvfROACNKqd38goOF6LfQfEeyNoYQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA9EV/aZhjYX1t/oD79Yrsmszo2Y5fuSKVDRBIawa5XczpeHTSI83HjDgeu7Sa82cWNmCFmv/S5
 iT9jEBLsoqQ8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index b06914223039..1a419a4a872c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -703,10 +703,24 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

