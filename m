Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694205;
	b=hPyJnk+/MAR4wvu2hV+tR8Ll8iGWPyuB7+lebRJGM+yPOTDeXPvyYWwUhuKIJMkDnpX5
	 pZhIQzrvZG6TVmKLXX2pxmYQyHJw2gv8AM+foLz+yWQmpKfF1WaAATTBP764+tMdVwzhc
	 6ITdK/jQAEfgbUVj2X/pU3oKTl2LwbpJbAv8lyfoLThpzvFHnEw3AswuVM36DMSFev2hB
	 iMj1AJZBFNEE5rKBOaqw43ED3MiDqOFhGChVmAaBfR3H2XdlM2v3mjjObKvhCaabxQn1K
	 OQsbP65R4VgDYAmCpi8cPn9qTdlXr7qh3EwrROckwgMVKtIZ2VjyN4R3t4BDuH9YUFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
	b=f3M2mIeKcL8cYqRKyVC2XGzt9qovu7b5Lg1SR6N+zGQl+HybYy6THlj97JJWmC4J+1B2
	 LvOD0NfSVj7XmrgwZbqcpvMTZIMjFK2zIDcKVmp1iuqm/hSBE/t3uoKzGNKq3ruIFIH8f
	 fK+ur2zktFDoOAYn6ktS6t+Im1VK21hmh1CU6B5e9fvsusTJuaBSR+KlfaxzlB0hlE7fd
	 Nh58R/UXg2R7/6/Jo4RiLGXgOrunpWwYvdpQJWwJKrtMXkgWep0WygjupIs0tN9J8ChJy
	 BpNgNE6X4xxXN2Pwp5ZXpmMCSdjueL3XVb9l82/XKeobNah+0M3MqL28Jk54KM4RqYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E2606A33C
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 18:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4E2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b89c6caffso1709166d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694204; x=1793299004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=F7z5QRbEHW8hNFtC9lVdaa1zTXyrbim1jVDneirl+zVZZRajgDmg3t4LLo6I8nDu8a
         RKIieFupHq+p9BNDrZlca1+DcUMUtlXzaY+uz3/nZCQyn6374BYmXT9UJ7qlIwEokWzF
         DPa0l4+FdMdpqUOlHQNSVyu1bULSLFht9Vp+xtYPi1ZNtqTvHpbwjZENIKQXBkBcy8pA
         FWTf6Z7cIVzuGPE2oatiP1e6+P4evADSipde4L5A/2eRrlYCTSxaQYmn1PyAmC8rrEcq
         Y4dO34r2xxWrgV3C/rruNnuW2dg4UQuMR7qTu/Hs0Bz9hs5NpzYPf8gN4UYgXwEOmWCv
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694204; x=1793299004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=w+vEbGzwFzIVmrHiZBx2CNyMGRzIQ6e85/2OXseE6+UFd5Blk3K3WjriCugr7aWNMB
         XFZhASuq/L+OTvh6P9apKxW/FtvvBTzcEClL5D1r/3kt5+evWobgUZDQT17eACVp/qgE
         Hx9tmwdjNOBEM2/lNF1hYKPGJW19Rx3uDNsWQJp41E6UDXyzIGHvwfcnd6EtoPewb9es
         4pYv6ZgFCYuQmLyl1+EXdSgykaSdCHFRtkfD4vX4MqtF50h4m7ueOaJCfTqxC5rUlzJs
         HkG3giTBeN5Fd+ncvhL+ayypxDimwjDN1rH0fkV2jyvvnb7YnApV2bl4KF0jQwCrHixB
         Bj7Q==
X-Forwarded-Encrypted: i=1; AKwUvBziF6uc+d5lro2xRGWKbda6mg4B84hsNUNOPeLRXqB68djeiF8U2jA4Y5jveKVZ88uZsd8WgQYvmdWOaKLF@vger.kernel.org
X-Gm-Message-State: AFq9FYIqbEcGDkcwiCZLOowkeqV5o8Y9jNf9YIBlwhD8Ujoo3oNFqp7t
	uUymijb+z0BbTd0gF5XTMK5/gjNTs/8qqY8GJXq4yX9vckkNJhE36alaWE5eVCDzd8A=
X-Gm-Gg: AYBFou2gwWs/++0o0vffi+vc37P3wYr/UbFugympGZgQ6l5iDs0KAeZNavcdqQ71RrU
	aWbywlu8yK1KJ7nfqGoO8gRTXP97KSSt5i4z0vcFTwBe37RD7bNFvnS9RGgOB3jgDu81G4Mysmb
	3ZXVZXReWxlio9fYgpYSwhFRSBlgD83C4jQkOIu9KHuDcON2deyZfIVkB5BSCZAuT5vASadl6TX
	qh0XFj89tS3KSyiuZ/38MdfE5fU+zn9HmCGmkZXnHLcR//LALaqkkSeV6wzf/YBMmGVF3XgI4Zm
	iLXDdwDct22D5i9XO3hirkKmUp0OttrjgK+Y++RiPKRLnpNue62VsWWHu1jgSE/7sygzvoEo7Sw
	J5elntU5F7rNL4fJlg26XIvKGPG8urucTiEhi8O0LKc1hW5yZ/Rz9+TtD8/oUjaW8AXRFYxLQkY
	7L0nIr8oPdfZ+i3pSq5nk5eMnBITKD7wYSad+tMC4NV875fHCwDJTwMBO0oZT4L8aLHrRiyZOIb
	xXeG62oSzPHxeemCg34riGSBxcUynfZXFms97vAsKuWBDlb52ZETtsdakEYLGzggxxO1+uX
X-Received: by 2002:a05:620a:2b97:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-93f6f941cb5mr51504685a.31.1792694204079;
        Thu, 22 Oct 2026 11:36:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fa79976sm20911585a.1.2026.10.22.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:22 +0000
Subject: [PATCH v4 4/5] capabilities: limit fscaps to where CAP_SETFCAP
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
Message-Id: <20261022-b4-setfcap-userns-v4-4-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=4387;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aZfwbbad7JbWE1sbfyYkODripimDq3vAr36rblWADSA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF3MVCsE+gzeGnl2Q+YtC/TsNj0oxCQUnKW3Si0zQrjO0OC244dOuQ90gD49mg97mO9JhJiHqi1
 k3NoNWYpR6As=
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

A v2 xattr skips the conversion when the writer has CAP_SETFCAP over the
filesystem's namespace, and belongs to that namespace's root user.  It
gets the same check: if that root user is out of reach, the xattr goes
through the conversion instead, and is refused there.  Otherwise a task
that unshared without CAP_SETFCAP could mount a tmpfs in its namespace,
write a v2 xattr on it, and have it honoured through an overlay mounted
from the initial namespace.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index b06914223039..655e822c8e76 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -694,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
-			/* user is privileged, just write the v2 */
-			return size;
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * Only write it unconverted if that root user is within reach, the
+	 * checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP) &&
+	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=
+	    task_ns->setfcap_level)
+		/* user is privileged, just write the v2 */
+		return size;
 
 	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
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

