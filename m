Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A249E5FC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301492; cv=none; b=ht+VTMsnvyQc6iFfCT6ukGST7cLEpttG7V5I+QT8dJ2a3PwDSbbWO7EyE24R1ZQ7CwUuxBIDnJOAYZbezkNnGL+PRkpeh0hudNmBX0MT1r615KLU65brLcRXVAcafScaTWaH1ZudQW6O2XEIZ21nB5W/YYbQeQmsyJR2EXo8BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301492; c=relaxed/simple;
	bh=AxdwV3jyCaz3acNcwVufe7ldBelGeRHhgWoXWQZiNGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQDMk8TlxeV1v74g2TXOHq5j0SittpTyalTtYMM2gItgK+JG4R8Yoxd80lbyaJoEmh0g2HbD0Mil1TLBXjpwzjam7ijiYS8ivbdHU7ECGqfjYweoO5E6Oq999n9ml+vUemAhM6TphDs6qNAHaepWUXT4XVXHoFL/Sbp/w8LjeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=dlDncMVu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="dlDncMVu"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917997ab0d9so7407226d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301488; x=1791906288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6fXKK9ddNXVDNgSu2OO+ZdNitAr8O+3Krqmr3ZLGjk4=;
        b=dlDncMVud+voktc9Oc/9Yg34Uf6mzglifxStOj1KPH0nJui51EzFxQAXBjZDMAUfkD
         jI0Y3SEB7lODLMfgdtWYK8jrwt/IDwZ5MagVeqzvNDkHd51hspDORmpv2BUColV8uUjg
         RWT7KsWl6xyG3z1YwKecvwbe+LvTIeF9KCmQ6wLPfH32O7L76LkLQMeqcr1rc2XGO+0P
         9vkMSgoTYhhRKNa7BD9b6k2xhaMe03Z3yKiIDouz/dAoHS6QW60mi2xxcfzkRT3JzPhV
         BVnI6U2WdIKz86Jgu4juylBbKom5aCop4fLQcvHaWF6C4rzQHa0Va1ErY8TlWq02z+rT
         C/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301488; x=1791906288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fXKK9ddNXVDNgSu2OO+ZdNitAr8O+3Krqmr3ZLGjk4=;
        b=kCAXTOJnXOzvVROlcmxEOaavsBx+zg5W3xej/8yGtp2iBwBhpiE4T/K5Xlt/dqwf+V
         iAj5e85hmDdwpslbLSVsv08/lU6JgT+Vogvd40hl9LEjkjDMnJnza6UHjGRPWSqZwaWY
         XjxcMsRhu0u7sGWIcnW69C2G/f/lC29n5UB7t9S4CGI2AJp49PcDowt9HqPMajk3Mero
         /SALJYhIUPUHqgyhQ5WQrl/BBCD0suJsCAIF66YYNHJ6+JjHPa9kxzsl9F3bg8/+oPBX
         gvq1IPhffZqu2l3d5HcKEV+AyIWmH1DkwkO1UVYU3K/XGHOMGjes0SnofkiMjlXSfhvF
         aAMg==
X-Forwarded-Encrypted: i=1; AKwUvBz1UOOl/eyEwt5r4GQV5pbVFDWDToGRD9HlqcI6V0JQsV6FbtXPEtmfVV1Cj2rHQh89et9iveZV+kHbnh5Z@vger.kernel.org
X-Gm-Message-State: AFuF++mRCiRVtWaW6J7iXE+91LOFLVO5DFbertc8QYGftCZMazmKs1YM
	TIpZcxVW7NoisnDazxXs4nDgsstvPClBZLG96obyQ3Xq+eI2xfwaoWz9Tt76P8STFBs=
X-Gm-Gg: AYBFou1vdCQebgKCbcXQ1fmFttVyPjWU2Zv+XEgHBw65/ar8Xe2gkocgPhvTItaLq4g
	c4KqbCd1NISYOpDflDT+N75Id38z0PIJH6Fmyvt46fE3XqT1+xVZv/zCmCSuq/6bX7jgwCjSttB
	DIwqm9cjfYkve+B2bO7FtRu02kLw9iKJxIRUso4kr+Fz9NOvw6gh0bxh7tukDOah/OSIL3SEnCy
	Av5WYoGXVI1bNeMYvy/je6vsgxENGPL0ot6y3HblO33dYq+7X58vImOezfeBfbb46HIBDa8uWBw
	kfrGAdiWB8YO/1KURDYq4IcCK7tJ/7FhlQjv4qVEkbJmjFaHrWWgHzmGEKd3x8V3SgYPgl7SO89
	3qpUFC5AhlhBa2rFiu/ZBIq0rCqw2Fh+Li5ZlUY5CJDrfM9l0Bigu7XjmvB9TRKloyUwfL8wU+J
	qArwghTURKV+WiOgaFSSjJxBTYnRb1EKOjnSq7qzdTgL8KW7vdHROHJ91naR1Nw8edMpg1XU6Mh
	aoaBktunw67IYw=
X-Received: by 2002:a05:6214:ca2:b0:919:518f:3a92 with SMTP id 6a1803df08f44-9198b7b2e97mr40909216d6.17.1791301487948;
        Tue, 06 Oct 2026 08:44:47 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bc98fbsm115732516d6.29.2026.10.06.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:19 +0000
Subject: [PATCH 3/5] userns: check the writer too before mapping uid 0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-3-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
In-Reply-To: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301478; l=3855;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AxdwV3jyCaz3acNcwVufe7ldBelGeRHhgWoXWQZiNGk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMY+oJ5hkLJYLy+wtpD0820OXDvDjzn/2W9uZiWzkpIndDjsoVu1mqh9U+PYTGYPqtnhE9LCKpf
 c5ivQuJCsBwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() only looks at file->f_cred.  For every other privileged
id mapping new_idmap_permitted() wants the capability from the opener of
the map file and from the task that calls write(), but a map that consists
of the single line "0 0 1" takes the unprivileged branch, where only the
opener's euid counts.  So an open uid_map file is a token for mapping
uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

B set up a mapping that it is not allowed to set up.

Apply to the writer what is applied to the opener: in the namespace that
is being mapped, its credentials must have come in with CAP_SETFCAP over
the parent; anywhere else it needs CAP_SETFCAP over the parent now.

This only affects maps that contain uid 0 of the parent namespace, and
only when the file was opened by a task with CAP_SETFCAP and is written to
by one without.  Those writes now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index bd5f9cea7430..421769e2d24f 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -891,8 +891,9 @@ EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
  * @new_map: requested idmap
  *
  * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * process that opened the map file and the process writing the map had the
+ * CAP_SETFCAP capability as the target process will be able to write fscaps
+ * that are valid in ancestor user namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -928,19 +929,28 @@ static bool verify_root_map(const struct file *file,
 		 * when it unshared, and that the opener, which may have come
 		 * in later with setns(), had it as well when it entered.
 		 */
-		if (!file_ns->parent_could_setfcap)
+		if (!file_ns->parent_could_setfcap ||
+		    file->f_cred->setfcap_level > level)
+			return false;
+	} else {
+		/* Process p1 is writing to uid_map of p2, who is in a child
+		 * user namespace to p1's.  Verify that the opener of the map
+		 * file has CAP_SETFCAP against the parent of the new map
+		 * namespace, and not just because it entered that.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    cap_setfcap_level(file->f_cred, map_ns->parent) > level)
 			return false;
-		return file->f_cred->setfcap_level <= level;
 	}
 
-	/* Process p1 is writing to uid_map of p2, who is in a child
-	 * user namespace to p1's.  Verify that the opener of the map
-	 * file has CAP_SETFCAP against the parent of the new map
-	 * namespace, and not just because it entered that.
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
 	 */
-	if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
-		return false;
-	return cap_setfcap_level(file->f_cred, map_ns->parent) <= level;
+	if (map_ns == current_user_ns())
+		return current_cred()->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cap_setfcap_level(current_cred(), map_ns->parent) <= level;
 }
 
 static ssize_t map_write(struct file *file, const char __user *buf,

-- 
2.55.0

